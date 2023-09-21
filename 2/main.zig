const std = @import("std");
const output = std.io.getStdOut().writer();

// rock         A - X -> 1
// paper        B - Y -> 2
// scissors     C - Z -> 3

pub fn main() !void {
    const data = try std.fs.cwd().readFileAlloc(std.heap.page_allocator, "input.txt", 65536);
    var total = try first(data);
    try output.print("result 2.1: {d} \n", .{total});
    total = try second(data);
    try output.print("result 2.2: {d} \n", .{total});
}

fn second(data: []u8) !i32 {
    var rounds = std.mem.split(u8, data, "\n");
    var total: i32 = 0;
    while (rounds.next()) |round| {
        if (round.len == 0) break;
        var hands = std.mem.split(u8, round, " ");
        switch (hands.next().?[0]) {
            'A' => {
                switch (hands.next().?[0]) {
                    'Z' => {
                        total += 2 + 6;
                    },
                    'Y' => {
                        total += 1 + 3;
                    },
                    'X' => {
                        total += 3 + 0;
                    },
                    else => {},
                }
            },
            'B' => {
                switch (hands.next().?[0]) {
                    'Z' => {
                        total += 3 + 6;
                    },
                    'Y' => {
                        total += 2 + 3;
                    },
                    'X' => {
                        total += 1 + 0;
                    },
                    else => {},
                }
            },
            'C' => {
                switch (hands.next().?[0]) {
                    'Z' => {
                        total += 1 + 6;
                    },
                    'Y' => {
                        total += 3 + 3;
                    },
                    'X' => {
                        total += 2 + 0;
                    },
                    else => {},
                }
            },
            else => {},
        }
    }
    return total;
}

fn first(data: []u8) !i32 {
    var rounds = std.mem.split(u8, data, "\n");
    var total: i32 = 0;
    while (rounds.next()) |round| {
        if (round.len == 0) break;
        var hands = std.mem.split(u8, round, " ");
        switch (hands.next().?[0]) {
            'A' => {
                switch (hands.next().?[0]) {
                    'Z' => {
                        total += 3 + 0;
                    },
                    'Y' => {
                        total += 2 + 6;
                    },
                    'X' => {
                        total += 1 + 3;
                    },
                    else => {},
                }
            },
            'B' => {
                switch (hands.next().?[0]) {
                    'Z' => {
                        total += 3 + 6;
                    },
                    'Y' => {
                        total += 2 + 3;
                    },
                    'X' => {
                        total += 1 + 0;
                    },
                    else => {},
                }
            },
            'C' => {
                switch (hands.next().?[0]) {
                    'Z' => {
                        total += 3 + 3;
                    },
                    'Y' => {
                        total += 2 + 0;
                    },
                    'X' => {
                        total += 1 + 6;
                    },
                    else => {},
                }
            },
            else => {},
        }
    }
    return total;
}
