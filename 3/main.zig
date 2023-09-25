const std = @import("std");
const output = std.io.getStdOut().writer();

pub fn main() !void {
    var data = try std.fs.cwd().readFileAlloc(std.heap.page_allocator, "input.txt", 65536);
    try output.print("result 3.1: {d}\n", .{try first(data)});
    try output.print("result 3.2: {d}\n", .{try second(data)});
}

fn second(data: []u8) !i32 {
    var it = std.mem.split(u8, data, "\n");
    var total: i32 = 0;
    while (it.next()) |item| {
        var part1 = item;
        var part2 = it.next() orelse "";
        var part3 = it.next() orelse "";
        var hm1 = std.AutoHashMap(u8, i32).init(std.heap.page_allocator);
        defer hm1.deinit();
        var hm2 = std.AutoHashMap(u8, i32).init(std.heap.page_allocator);
        defer hm2.deinit();
        for (part1) |c| {
            try hm1.put(c, 10);
        }
        for (part2) |c| {
            try hm2.put(c, 10);
        }
        for (part3) |c| {
            if (hm1.contains(c) and hm2.contains(c)) {
                switch (c) {
                    'a'...'z' => {
                        total += c - 96;
                    },
                    'A'...'Z' => {
                        total += c - 65 + 27;
                    },
                    else => {},
                }
                break;
            }
        }
    }
    return total;
}

fn first(data: []u8) !i32 {
    var it = std.mem.split(u8, data, "\n");
    var total: i32 = 0;
    while (it.next()) |item| {
        var part1 = item[0 .. item.len / 2];
        var part2 = item[item.len / 2 ..];
        var hm = std.AutoHashMap(u8, i32).init(std.heap.page_allocator);
        defer hm.deinit();
        for (part1) |c| {
            try hm.put(c, 10);
        }
        for (part2) |c| {
            if (hm.contains(c)) {
                switch (c) {
                    'a'...'z' => {
                        total += c - 96;
                    },
                    'A'...'Z' => {
                        total += c - 65 + 27;
                    },
                    else => {},
                }
                break;
            }
        }
    }
    return total;
}
