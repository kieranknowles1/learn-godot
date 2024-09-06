use godot::prelude::*;
use godot::classes::{CharacterBody2D, ICharacterBody2D};

type Base = godot::prelude::Base<CharacterBody2D>;

#[derive(GodotClass)]
#[class(base = CharacterBody2D)]
struct Player {
    // Hold the parent class as a field.
    base: Base,
    speed: f32,
}


// Expose the impl to Godot.
#[godot_api]
impl ICharacterBody2D for Player {
    fn init(base: Base) -> Self {
        Player {
            base,
            speed: 100.0,
        }
    }

    fn physics_process(&mut self, delta: f64) {
        let pos = self.base().get_position();
        let delta_x = self.speed * delta as f32;

        self.base_mut().set_position(Vector2 {
            x: pos.x + delta_x,
            y: pos.y,
        })
    }
}
