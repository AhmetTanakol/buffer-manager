#include <iostream>
#include <string>
#include <mutex>  // For std::unique_lock
#include <shared_mutex>

#include "moderndbs/buffer_manager.h"
#include "moderndbs/file.h"


namespace moderndbs {

    char* BufferFrame::get_data() {
        auto data = reinterpret_cast<char *>(this->frameVector.data());
        return data;
    }


    BufferManager::BufferManager(size_t page_size, size_t page_count) {
        this->pageSize = page_size;
        this->pageCount = page_count;
    }

    BufferFrame::BufferFrame(size_t page_id, bool is_dirty, uint64_t frame_size) {
        this->pageID = page_id;
        this->isDirty = is_dirty;
        if (this->frameVector.size() == 0) {
            this->frameVector.resize(frame_size / sizeof(uint64_t));
        }
    }



    BufferManager::~BufferManager() {
        /// Write dirty pages in fifo queue into file
        for (auto f : fifo) {
            if (f.getDirty()) {
                std::string file_name = std::to_string(BufferManager::get_segment_id(f.getPageID()));
                const char* filename = file_name.c_str();
                auto file = File::open_file(filename, File::WRITE);
                uint64_t offSet = get_segment_page_id(f.getPageID()) * pageSize;
                file->write_block(reinterpret_cast<char *>(f.getFrameVector().data()), offSet, pageSize);
            }
        }
        /// Write dirty pages in lru queue into file
        for (auto l : lru) {
            if (l.getDirty()) {
                std::string file_name = std::to_string(BufferManager::get_segment_id(l.getPageID()));
                const char* filename = file_name.c_str();
                auto file = File::open_file(filename, File::WRITE);
                uint64_t offSet = get_segment_page_id(l.getPageID()) * pageSize;
                file->write_block(reinterpret_cast<char *>(l.getFrameVector().data()), offSet, pageSize);
            }
        }
    }


    BufferFrame& BufferManager::fix_page(uint64_t page_id, bool exclusive) {
        std::vector<uint64_t> values;
        if (fifoMap.count(page_id) == 0 && lruMap.count(page_id) == 0) {
            values.resize(pageSize / sizeof(uint64_t));
            std::string file_name = std::to_string(BufferManager::get_segment_id(page_id));
            const char* filename = file_name.c_str();
            auto file = File::open_file(filename, File::WRITE);
            uint64_t offSet = BufferManager::get_segment_page_id(page_id) * pageSize;
            file->read_block(offSet, pageSize, reinterpret_cast<char *>(values.data()));
        }
        if (exclusive) {
            page_mutex.lock();
        } else {
            page_mutex.lock_shared();
        }

        BufferFrame newPage(page_id, false, pageSize);
        newPage.setExclusiveLock(exclusive);
        if (values.size() > 0) {
            newPage.setFrameVector(values);
        }

        vector_mutex.lock();
        //std::cout << "Fix page: " << page_id << std::endl;
        if (fifo.size() == 0 && lru.size() == 0) {
            fifo.push_back(newPage);
            fifoMap.insert( std::pair<uint64_t,int>(page_id,0) );
            if (!exclusive) {
                page_mutex.unlock_shared();
            }
            vector_mutex.unlock();
            return fifo.back();
        }
        /// Check if page id exists in lru vector
        /// Erase it, and change its position
        if (lruMap.count(page_id) > 0) {
            int position = lruMap[page_id];
            newPage.setDirty(lru[position].getDirty());
            newPage.setFrameVector(lru[position].getFrameVector());
            lru.erase(lru.begin()+position);
            lru.push_back(newPage);
            /// Reassign all positions in lruMap
            lruMap.clear();
            for (int i=0;i < static_cast<int>(lru.size()); i++) {
                lruMap.insert( std::pair<uint64_t,int>(lru[i].getPageID(), i) );
            }
            if (!exclusive) {
                page_mutex.unlock_shared();
            }
            vector_mutex.unlock();
            return lru.back();
        }

        /// Check if page id exists in fifo vector
        /// If it exists and there is enough memory, push it into lru vector
        if (fifoMap.count(page_id) > 0) {
            if ((lru.size() + fifo.size()) < pageCount) {
                int position = fifoMap[page_id];
                newPage.setDirty(fifo[position].getDirty());
                newPage.setFrameVector(fifo[position].getFrameVector());
                fifo.erase(fifo.begin()+position);
                fifoMap.clear();
                /// Reassign all positions in fifoMap
                for (int i=0;i < static_cast<int>(fifo.size()); i++) {
                    fifoMap.insert( std::pair<uint64_t,int>(fifo[i].getPageID(), i) );
                }
                lru.push_back(newPage);
                int positionInLruVector = lru.size() - 1;
                lruMap.insert( std::pair<uint64_t,int>(page_id, positionInLruVector) );
                if (!exclusive) {
                    page_mutex.unlock_shared();
                }
                vector_mutex.unlock();
                return lru.back();
            }
            /// If there is an unfixed and not dirty page in lru vector
            /// Remove it and add the new page id
            for (int i = 0; i < static_cast<int>(lru.size()); i++) {
                if (lru[i].getCounter() == 0 && !lru[i].getDirty()) {
                    lru.erase(lru.begin() + i);
                    lru.push_back(newPage);
                    lruMap.clear();
                    /// Reassign all positions in lruMap
                    for (int j=0;j < static_cast<int>(lru.size()); j++) {
                        lruMap.insert( std::pair<uint64_t,int>(lru[j].getPageID(), j) );
                    }
                    if (!exclusive) {
                        page_mutex.unlock_shared();
                    }
                    vector_mutex.unlock();
                    return lru.back();
                }
            }

            /// If there is a page id in lru which was unfixed and dirty
            /// Write it into disk, remove it and insert the new page id
            for (int i = 0; i < static_cast<int>(lru.size()); i++) {
                if (lru[i].getCounter() == 0 && lru[i].getDirty()) {
                    uint64_t tempID = lru[i].getPageID();
                    std::vector<uint64_t> tempVector = lru[i].getFrameVector();
                    lru.erase(lru.begin() + i);
                    lru.push_back(newPage);
                    lruMap.clear();
                    /// Reassign all positions in lruMap
                    for (int j=0;j < static_cast<int>(lru.size()); j++) {
                        lruMap.insert( std::pair<uint64_t,int>(lru[j].getPageID(), j) );
                    }
                    if (exclusive) {
                        page_mutex.unlock();
                    } else {
                        page_mutex.unlock_shared();
                    }
                    vector_mutex.unlock();
                    std::string file_name = std::to_string(BufferManager::get_segment_id(tempID));
                    const char* filename = file_name.c_str();
                    auto file = File::open_file(filename, File::WRITE);
                    uint64_t offSet = get_segment_page_id(tempID) * pageSize;
                    file->write_block(reinterpret_cast<char *>(tempVector.data()), offSet, pageSize);
                    if (exclusive) {
                        page_mutex.lock();
                    }
                    return lru.back();
                }
            }
        }
        /// Check if there is enough memory to push page id into fifo vector
        if ((lru.size() + fifo.size()) < pageCount) {
            fifo.push_back(newPage);
            int positionInFifoVector = fifo.size() - 1;
            fifoMap.insert( std::pair<uint64_t,int>(page_id, positionInFifoVector) );
            if (!exclusive) {
                page_mutex.unlock_shared();
            }
            vector_mutex.unlock();
            return fifo.back();
        }
        /// If there is a page id which was unfixed and not dirty
        /// Remove it and insert the new page id
        for (int i = 0; i < static_cast<int>(fifo.size()); i++) {
            if (fifo[i].getCounter() == 0 && !fifo[i].getDirty()) {
                fifo.erase(fifo.begin() + i);
                fifo.push_back(newPage);
                fifoMap.clear();
                /// Reassign all positions in fifoMap
                for (int j=0;j < static_cast<int>(fifo.size()); j++) {
                    fifoMap.insert( std::pair<uint64_t,int>(fifo[j].getPageID(), j) );
                }
                if (!exclusive) {
                    page_mutex.unlock_shared();
                }
                vector_mutex.unlock();
                return fifo.back();
            }
        }

        /// If there is a page id which was unfixed and dirty
        /// Write it into disk, remove it and insert the new page id
        for (int i = 0; i < static_cast<int>(fifo.size()); i++) {
            if (fifo[i].getCounter() == 0 && fifo[i].getDirty()) {
                uint64_t tempID = fifo[i].getPageID();
                std::vector<uint64_t> tempVector = fifo[i].getFrameVector();
                fifo.erase(fifo.begin() + i);
                fifo.push_back(newPage);
                fifoMap.clear();
                /// Reassign all positions in fifoMap
                for (int j=0;j < static_cast<int>(fifo.size()); j++) {
                    fifoMap.insert( std::pair<uint64_t,int>(fifo[j].getPageID(), j) );
                }
                if (exclusive) {
                    page_mutex.unlock();
                } else {
                    page_mutex.unlock_shared();
                }
                vector_mutex.unlock();
                std::string file_name = std::to_string(BufferManager::get_segment_id(tempID));
                const char* filename = file_name.c_str();
                auto file = File::open_file(filename, File::WRITE);
                uint64_t offSet = get_segment_page_id(tempID) * pageSize;
                file->write_block(reinterpret_cast<char *>(tempVector.data()), offSet, pageSize);
                if (exclusive) {
                    page_mutex.lock();
                }
                return fifo.back();
            }
        }
        vector_mutex.unlock();
        if (exclusive) {
            page_mutex.unlock();
        } else {
            page_mutex.unlock_shared();
        }
        throw buffer_full_error{};
    }


    void BufferManager::unfix_page(BufferFrame& page, bool is_dirty) {
        //std::cout << "Unfix page: " << page.getPageID() << std::endl;
        vector_mutex.lock();
        if (fifoMap.count(page.getPageID()) > 0) {
            int position = fifoMap.at(page.getPageID());
            fifo[position].setCounter();
            fifo[position].setDirty(is_dirty);
        }

        if (lruMap.count(page.getPageID()) > 0) {
            int position = lruMap.at(page.getPageID());
            lru[position].setCounter();
            lru[position].setDirty(is_dirty);
        }
        if (page.getExclusiveLock()) {
            page_mutex.unlock();
        }
        vector_mutex.unlock();
    }


    std::vector<uint64_t> BufferManager::get_fifo_list() const {
        std::vector<uint64_t> values;
        for (BufferFrame frame: this->fifo) {
            values.push_back(frame.getPageID());
        }
        return values;
    }


    std::vector<uint64_t> BufferManager::get_lru_list() const {
        std::vector<uint64_t> values;
        for (BufferFrame frame: this->lru) {
            values.push_back(frame.getPageID());
        }
        return values;
    }

}  // namespace moderndbs
