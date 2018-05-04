#ifndef INCLUDE_MODERNDBS_BUFFER_MANAGER_H
#define INCLUDE_MODERNDBS_BUFFER_MANAGER_H

#include <cstddef>
#include <cstdint>
#include <exception>
#include <vector>
#include <mutex>
#include <shared_mutex>
#include <map>

namespace moderndbs {

class BufferFrame {
private:
    friend class BufferManager;

    uint64_t pageID;
    bool isDirty = false;
    int counter = 1;
    std::vector<uint64_t> frameVector;
    bool hasExclusiveLock = false;

public:
    /// Returns a pointer to this page's data.
    char* get_data();

    BufferFrame(size_t page_id, bool is_dirty, uint64_t frame_size);

    void setDirty(bool is_dirty) {
        this->isDirty = is_dirty;
    }

    bool getDirty() {
        return this->isDirty;
    }

    void setCounter() {
        this->counter = 0;
    }

    int getCounter() {
        return this->counter;
    }

    uint64_t getPageID() {
        return this->pageID;
    }

    std::vector<uint64_t> getFrameVector() {
        return this->frameVector;
    }

    void setFrameVector(std::vector<uint64_t > vec) {
        this->frameVector = std::move(vec);
    }

    void setExclusiveLock(bool exclusive) {
        this->hasExclusiveLock = exclusive;
    }

    bool getExclusiveLock() {
        return this->hasExclusiveLock;
    }
};


class buffer_full_error
: public std::exception {
public:
    const char* what() const noexcept override {
        return "buffer is full";
    }
};


class BufferManager {
private:
    std::vector<BufferFrame> fifo;
    std::vector<BufferFrame> lru;
    size_t pageSize;
    size_t pageCount;
    mutable std::shared_mutex vector_mutex;
    mutable std::shared_mutex page_mutex;
    std::map<uint64_t, int> fifoMap;
    std::map<uint64_t, int> lruMap;

public:
    /// Constructor.
    /// @param[in] page_size  Size in bytes that all pages will have.
    /// @param[in] page_count Maximum number of pages that should reside in
    //                        memory at the same time.
    BufferManager(size_t page_size, size_t page_count);

    /// Destructor. Writes all dirty pages to disk.
    ~BufferManager();

    /// Returns a reference to a `BufferFrame` object for a given page id. When
    /// the page is not loaded into memory, it is read from disk. Otherwise the
    /// loaded page is used.
    /// When the page cannot be loaded because the buffer is full, throws the
    /// exception `buffer_full_error`.
    /// Is thread-safe w.r.t. other concurrent calls to `fix_page()` and
    /// `unfix_page()`.
    /// @param[in] page_id   Page id of the page that should be loaded.
    /// @param[in] exclusive If `exclusive` is true, the page is locked
    ///                      exclusively. Otherwise it is locked
    ///                      non-exclusively (shared).
    BufferFrame& fix_page(uint64_t page_id, bool exclusive);

    /// Takes a `BufferFrame` reference that was returned by an earlier call to
    /// `fix_page()` and unfixes it. When `is_dirty` is / true, the page is
    /// written back to disk eventually.
    void unfix_page(BufferFrame& page, bool is_dirty);

    /// Returns the page ids of all pages (fixed and unfixed) that are in the
    /// FIFO list in FIFO order.
    /// Is not thread-safe.
    std::vector<uint64_t> get_fifo_list() const;

    /// Returns the page ids of all pages (fixed and unfixed) that are in the
    /// LRU list in LRU order.
    /// Is not thread-safe.
    std::vector<uint64_t> get_lru_list() const;

    /// Returns the segment id for a given page id which is contained in the 16
    /// most significant bits of the page id.
    static constexpr uint16_t get_segment_id(uint64_t page_id) {
        return page_id >> 48;
    }

    /// Returns the page id within its segment for a given page id. This
    /// corresponds to the 48 least significant bits of the page id.
    static constexpr uint64_t get_segment_page_id(uint64_t page_id) {
        return page_id & ((1ull << 48) - 1);
    }
};


}  // namespace moderndbs

#endif
