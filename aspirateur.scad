module aspirateur()
{
	translate([175,0,0])
	difference() {
		cylinder(r=175,h=100);
		translate([186.303,0,-0.1])
			cylinder(r=103,h=100+0.2);
		translate([186.303-66-40,-216/2,25])
				cube([66,216,100-25+0.1]);
	}
}


module bras_droit()
{
	epaisseur = 3;
	short_len = 40;
	offset_len = 0;
	global_len= 95;
	angle = 120;
	height= 60;
	alpha = 180-angle;
	temp_len = global_len / sin(alpha);
	long_len = temp_len*sin(alpha-asin(short_len/temp_len));
	h_trou = 36;
	l_trou = 22;
	
	difference(){
		union() {
			//plaques
			translate([-epaisseur/2,-short_len-offset_len,0]) {
				cube([epaisseur,short_len+offset_len-9/2,height]);
				rotate([0,0,-angle])
					translate([-epaisseur,0,0])
						cube([epaisseur,long_len,height]);
			}
			
			// rondelle fixation
			difference() {
				translate([0,0,h_trou])
					cylinder(d=21,h=7);
					cylinder(d=9,h=height);
			}
		}
		// trou passage servo
		difference() {
			translate([-epaisseur/2-0.1,-l_trou,0])
				cube([epaisseur+0.2,l_trou,h_trou]);
		}
		translate([0,0,h_trou+7])
		rotate([-45,0,0])
		translate([-epaisseur/2-0.1,-short_len,0])
		cube([epaisseur+0.2,short_len,height]);	
	}
	translate([-epaisseur/2,-l_trou,h_trou-10*sqrt(2)/2])
		rotate([45,0,0])
			cube([epaisseur,10,10]);
}

module servo()
{
	//body
	translate([-31,-20/2,0])
		cube([41,20,39]);
	//fixation
	translate([-31-(55-41)/2,-20/2,27])
		cube([55,20,2.5]);
	//shaft
	translate([0,0,39])
		cylinder(d=6,h=4);
}


module bras_gauche()
{
	mirror([0,1,0]) bras_droit();
}

module max_perim_deploy()
{
	translate([1500/PI/2,0,0]) cylinder(d=1500/PI);
}

module max_perim_non_deploy()
{
	translate([1200/PI/2,0,0]) cylinder(d=1200/PI);
}

module zone_minerai()
{
	//translate([125,0,0])
	for(angle=[30:60:330]) {
		rotate([0,0,angle])
			translate([170/2,-100/2,0])
				cube([30,100,4]);
	}
}

module minerai()
{
	color([0.9,0.9,0.9])
		translate([0,0,60/2])
		sphere(d=60);
}

angle_rot = 80;
translate([315,-98,30]) rotate([0,0,angle_rot])
	bras_droit();
translate([315,98,30]) rotate([0,0,-angle_rot])
	bras_gauche();
translate([315,0,25]) {
	translate([0,-98,0]) servo();
	translate([0,98,0]) servo();
}

aspirateur();

translate([300,0,0]) cylinder(d=63,h=100);

color([1,0,0]) max_perim_deploy();
color([0,1,0]) max_perim_non_deploy();

color([0,0,1]) translate([350-40,0,0]) zone_minerai();
translate([350,60,0]) minerai();
translate([350,-60,0]) minerai();
translate([360,0,0]) minerai();
translate([296,31,0]) minerai();
translate([296,-31,0]) minerai();

bras_droit();

