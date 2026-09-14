
# Synchronous FIFO

A synchronous First-In-First-Out (FIFO) buffer implemented in Verilog RTL.

The design uses a single clock domain and consists of a FIFO memory,
read/write pointer control, and status logic for detecting empty and
full conditions.

---

## 1. Project Overview

This project implements a synchronous FIFO with:

- 16-bit data width
- 8 memory locations
- Synchronous read and write operations
- Read and write pointers
- Empty and full status flags
- Synchronous active-low reset

The FIFO follows the First-In-First-Out principle, where the first
data written into the FIFO is the first data read from it.

### Main Operations

A write operation occurs when:

    wr_en = 1
    full  = 0

A read operation occurs when:

    rd_en = 1
    empty = 0

Write and read operations are synchronized to the rising edge of
the system clock.

---

## 2. Design Specifications

| Parameter | Value |
|---|---:|
| Data Width | 16 bits |
| Memory Locations | 8 |
| Pointer Width | 3 bits |
| Clock | Single synchronous clock |
| Reset | Active-low synchronous reset |
| Read Operation | Synchronous |
| Write Operation | Synchronous |
| Status Flags | `full`, `empty` |

---

## 3. Architecture

The design consists of three main functional blocks:

1. FIFO Core
2. FIFO Status Logic
3. Top-Level Integration

### Block Diagram

(<img width="773" height="383" alt="image" src="https://github.com/user-attachments/assets/9ade0b37-1d90-4b1c-87f1-78c6838e11c9" />)

The `fifo_core` contains the FIFO memory and controls the read/write
pointers.

The `fifo_status` block generates the `full` and `empty` status flags
based on the current read and write pointers.

The top-level module connects these blocks together and exposes the
external FIFO interface.

---

## 4. Module Hierarchy

```text
top
│
├── fifo_core
│   ├── FIFO memory
│   ├── Write pointer
│   └── Read pointer
│
├── fifo_status
│   ├── Full detection
│   └── Empty detection
│
└── onetotwo
    ├── Full flag connection
    └── Empty flag connection

| File                          | Module        | Description                        |
| ----------------------------- | ------------- | ---------------------------------- |
| `SynchronousFIFO_Topmodule.v` | `top`         | Top-level integration              |
| `FIFO_Core.v`                 | `fifo_core`   | FIFO memory and read/write control |
| `FIFO_Status.v`               | `fifo_status` | Generates `full` and `empty`       |
| `OnetoTwo.v`                  | `onetotwo`    | Signal connection/buffering block  |

