use std::char;
use termbox_sys::*;

#[derive(Copy, Clone, PartialEq, Eq, Debug)]
pub enum Key {
    Ch(char),
    Code(u16),
}

pub struct Terminal;

impl Terminal {
    pub fn new() -> Terminal { unsafe { tb_init(); } Terminal }

    pub fn getch(&self) -> Key {
        let ev = RawEvent { etype: 0, emod: 0, key: 0, ch: 0, w: 0, h: 0, x: 0, y: 0 };
        loop {
            let rc = unsafe { tb_poll_event(&ev as *const RawEvent) };
            if rc == 1 { break; }
        }

        let ch = char::from_u32(ev.ch);
        match ch {
            Some(ch) if ch != '\0' => Key::Ch(ch),
            _ => Key::Code(ev.key)
        }
    }

    pub fn present(&self) { unsafe { tb_present(); } }

    pub fn print(&self, x: i32, y: i32, fg: u16, bg: u16, s: &str) {
        for (i, c) in s.chars().enumerate() {
            unsafe { tb_change_cell(x + i as i32, y, c as u32, fg, bg); }
        }
    }
}

impl Drop for Terminal { fn drop(&mut self) { unsafe { tb_shutdown(); } } }

pub const DOWN: Key = Key::Code(65516);
pub const UP: Key = Key::Code(65517);
pub const LEFT: Key = Key::Code(65515);
pub const RIGHT: Key = Key::Code(65514);
