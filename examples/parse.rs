use std::path::PathBuf;

use xin::parser::NixConfig;

fn main() {
    let file = std::env::args()
        .nth(1)
        .expect("expected a file as an argument");
    let path = PathBuf::from(file);
    let settings = NixConfig::parse_file(&path);

    match settings {
        Ok(settings) => {
            eprintln!("{settings:?}");
        }
        Err(settings) => {
            eprintln!("{settings}");
        }
    }
}
