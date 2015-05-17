extern crate termbox_sys;

mod term;

use term::*;

static MAP: [&'static str; 10] = [
    "####  ####",
    "#  ####  #",
    "#        #",
    "##      ##",
    " #      # ",
    " #      # ",
    "##      ##",
    "#        #",
    "#  ####  #",
    "####  ####"];

pub struct SimpleRL {
    px: i32,
    py: i32,
}

impl SimpleRL {
    pub fn new() -> SimpleRL { SimpleRL { px: 1, py: 1 } }

    pub fn draw(&self, term: &Terminal) {
        for (y, line) in MAP.iter().enumerate() {
            term.print(0, y as i32, 15, 0, line);
        }
        term.print(self.px, self.py, 15, 0, "@");
    }
   
    pub fn step(&mut self, dx: i32, dy: i32) {
        let (x, y) = (self.px + dx, self.py + dy);
        if MAP[y as usize].chars().nth(x as usize).unwrap() == ' ' {
            self.px = x;
            self.py = y;
        }
    }
}

fn main() {
    let term = Terminal::new();
    let mut game = SimpleRL::new();
    loop {
        game.draw(&term);
        term.present();

        match term.getch() {
            Key::Ch('q') => { break; }
            UP => { game.step(0, -1); }
            LEFT => { game.step(-1, 0); }
            RIGHT => { game.step(1, 0); }
            DOWN => { game.step(0, 1); }
            _ => {}
        }
    }
}
