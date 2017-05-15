from solid import *
from solid.utils import *

SEGMENTS=50

thickness=3
start_radius=21/2
end_radius=1
final_angle=90
final_center_to_center_len=30
step = 1

d = cylinder(start_radius,thickness)

for i in frange(1, final_angle, step):
	d += rotate([0,0,i]) (
			translate([i/final_angle*final_center_to_center_len,0,0]) (
				cylinder(start_radius-i*(start_radius-end_radius)/final_angle, thickness)
			)
		 )

d -= translate([0,0,-0.1]) (
		cylinder(d=9, h=thickness+0.2)
	 )

scad_render_to_file(d, "cylinder_pusher(generated).scad", file_header='$fn = %s;' % SEGMENTS)
