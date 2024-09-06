use godot::prelude::*;

mod player;

// Doesn't do anything, just an entry point for the library.
struct GodotEntry;

// Unsafe as Godot doesn't have the same guarantees as Rust.
#[gdextension]
unsafe impl ExtensionLibrary for GodotEntry {}
