use <moteur_roue.scad>

translate([0,0,0])
{
	translate([0,-130,75/2]) 
		moteur_roue("Phoenix Robotik",align="ext");
	translate([0,130,75/2]) rotate([0,0,180]) 
		moteur_roue("Phoenix Robotik",align="ext");
	color([0.3,0.3,0.2])
	{
		translate([-20,130-30,0]) cube([20,20,20]);
		translate([-20,-130+30-20,0]) cube([20,20,20]);
	}
}
translate([50,-130,10])
{
	%cube([170+30-50+10,260,5]); //170+30-50+10 = 160 : 160+210=370, 370*2+260*2=1260
}
//cylinder(d=270);
translate([170/2,0,0]){
//color([0,1,0]) cube([170,170,20],center=true);
	}

translate([170/2+30,0,0])
for(angle=[30:60:330])
{
	rotate([0,0,angle])
		color([1,0,0])
			translate([170/2,-100/2,0])
				cube([30,100,4]);
}

translate([0,0,-10]) color([0.6,1,1])
	cube([1000,1000,20],center=true);