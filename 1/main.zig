const std = @import("std");
const output = std.io.getStdOut();

pub fn main() !void {
    var data = try std.fs.cwd().readFileAlloc(std.heap.page_allocator, "input.txt", 65536);
    var result = try first(data);
    try output.writer().print("result 1.1: {d} \n", .{result});
    result = try second(data);
    try output.writer().print("result 1.2: {d} \n", .{result});
}

fn first(data: []u8) !i32 {
    var elfs = std.mem.split(u8, data, "\n\n");
    var max: i32 = 0;
    while (elfs.next()) |elf| {
        var elfIt = std.mem.split(u8, elf, "\n");
        var t: i32 = 0;
        while (elfIt.next()) |c| {
            if (c.len == 0) break;
            var temp = try std.fmt.parseInt(i32, c, 10);
            t = t + temp;
        }
        if (t > max) {
            max = t;
        }
    }
    return max;
}
fn second(data: []u8) !i32 {
    var elfs = std.mem.split(u8, data, "\n\n");
    var list = std.ArrayList(i32).init(std.heap.page_allocator);
    defer list.deinit();
    while (elfs.next()) |elf| {
        var elfIt = std.mem.split(u8, elf, "\n");
        var t: i32 = 0;
        while (elfIt.next()) |c| {
            if (c.len == 0) break;
            var temp = try std.fmt.parseInt(i32, c, 10);
            t = t + temp;
        }
        try list.append(t);
    }
    std.mem.sort(i32, list.items, {}, comptime std.sort.desc(i32));
    var total: i32 = 0;
    var i: u32 = 0;
    while (i < 3) : (i += 1) {
        total += list.items[i];
    }
    return total;
}
