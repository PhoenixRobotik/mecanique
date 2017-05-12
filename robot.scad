
use <moteur_roue.scad>
use <piece_fixation.scad>

garde_au_sol=20;
hauteur_robot=335;
profondeur_robot=210;
largeur_robot=260;
hauteur_support_balise=430;
cote_support_balise=80;

module roues()
{
	longueur_fixation_moteur=106;
	longueur_meplat=42;
	profondeur=13.5;
	dia_roues=75;
	epaisseur_plaque=5;

	translate([0,0,dia_roues/2])
	{
		translate([0,0,-profondeur+(13-16/2)])
		{
			piece_fixation(longueur_fixation_moteur);
			translate([0,0,profondeur+epaisseur_plaque/2])
				cube([46.5345,longueur_fixation_moteur,epaisseur_plaque],center=true);
		}

		translate([0,-longueur_fixation_moteur/2+longueur_meplat+2,0])
				moteur_roue(align="axe");
		rotate([0,0,180])
		translate([0,-longueur_fixation_moteur/2+longueur_meplat+2,0])
				moteur_roue(align="axe");
	}
	echo("h_fixation = ",dia_roues/2-16/2+13+epaisseur_plaque);
}

module plaque_bas(marge_bord)
{
	difference()
	{
		translate([marge_bord,-largeur_robot/2+marge_bord])
			square([profondeur_robot-2*marge_bord,
					largeur_robot-2*marge_bord]);
		translate([0,+largeur_robot/2-75])
			square([75,75]);
		translate([0,-largeur_robot/2])
			square([75,75]);
	}
}

module plaque_ar(marge_haut)
{
	h_trou_roues=75;
	difference()
	{
		translate([garde_au_sol,-largeur_robot/2])
			square([hauteur_robot-garde_au_sol-marge_haut,largeur_robot]);
			translate([0,+largeur_robot/2-75]) square([h_trou_roues,75]);
			translate([0,-largeur_robot/2]) square([h_trou_roues,75]);
	}
}

module plaque_av(marge_haut)
{
	translate([garde_au_sol,-largeur_robot/2])
		square([hauteur_robot-garde_au_sol-marge_haut,largeur_robot]);
}

module plaque_gd(marge_haut,marge_bord)
{
	difference()
	{
		translate([marge_bord,garde_au_sol])
			square([profondeur_robot-2*marge_bord,hauteur_robot-garde_au_sol-marge_haut]);
		polygon([[marge_bord,garde_au_sol],[marge_bord,75],[60,75],[85,garde_au_sol]]);
//		square([75,75]);
	}
}

module plaque_haut()
{
	translate([0,-largeur_robot/2])
		square([profondeur_robot,largeur_robot]);
}

module balise_haut()
{
	translate([0,-cote_support_balise/2])
		square([cote_support_balise,cote_support_balise]);
}

module balise_gd(marge_haut)
{
	marge_hb=10;
	break=marge_hb+15;
	marge_gd=20;
	hauteur=hauteur_support_balise-hauteur_robot-marge_haut;
	difference()
	{
		square([cote_support_balise,hauteur]);
		polygon([[0,marge_hb],[marge_gd,break],[marge_gd,hauteur-break],[0,hauteur-marge_hb]]);
		translate([cote_support_balise,0]) rotate([0,180])
		polygon([[0,marge_hb],[marge_gd,break],[marge_gd,hauteur-break],[0,hauteur-marge_hb]]);
	}
}

module patin(cote)
{
	cube([cote,cote,47.5]);
}

module robot()
{
	epaisseur=9;
	translate([75/2,0,0]) roues();
	// bas
	translate([0,0,47.5])
	{
		linear_extrude(epaisseur) plaque_bas(epaisseur);
		color([0,0,0]) translate([0,0,epaisseur-1])
			linear_extrude(1) plaque_bas(epaisseur);
	}
	// arrière
	rotate([0,-90,0]) translate([0,0,-epaisseur])
	{
		linear_extrude(epaisseur) plaque_ar(epaisseur);
		color([0,0,0])
			linear_extrude(1) plaque_ar(epaisseur);
	}
	// avant
	translate([profondeur_robot,0,0]) rotate([0,-90,0])
	{
		linear_extrude(epaisseur) plaque_av(epaisseur);
		color([0,0,0]) translate([0,0,epaisseur-1])
			linear_extrude(1) plaque_av(epaisseur);
	}
	// gauche
	translate([0,largeur_robot/2,0]) rotate([90,0,0])
	{
		linear_extrude(epaisseur) plaque_gd(epaisseur,epaisseur);
		color([0,0,0]) translate([0,0,epaisseur-1])
			linear_extrude(1) plaque_gd(epaisseur,epaisseur);
	}
	// droite
	translate([0,-largeur_robot/2+epaisseur,0]) rotate([90,0,0])
	{
		linear_extrude(epaisseur) plaque_gd(epaisseur,epaisseur);
		color([0,0,0])
			linear_extrude(1) plaque_gd(epaisseur,epaisseur);
	}
	// haut
	translate([0,0,hauteur_robot-epaisseur])
	{
		linear_extrude(epaisseur) plaque_haut();
		color([0,0,0]) linear_extrude(1) plaque_haut();
	}
	// balise haut
	translate([profondeur_robot/2-cote_support_balise/2,0,hauteur_support_balise-epaisseur])
	{
		linear_extrude(epaisseur) balise_haut(epaisseur);
		color([0,0,0])
			linear_extrude(1) balise_haut(epaisseur);
		color([0,0,0]) translate([0,0,epaisseur-1])
			linear_extrude(1) balise_haut(epaisseur);
	}
	// patins
	largeur_patin=30;
	translate([profondeur_robot-largeur_patin-epaisseur,0])
	{
		// gauche
		translate([0,largeur_robot/2-epaisseur-largeur_patin])
			patin(largeur_patin);
		// droite
		translate([0,-largeur_robot/2+epaisseur])
			patin(largeur_patin);
	}
	// balise gauche
	translate([profondeur_robot/2-cote_support_balise/2,cote_support_balise/2,hauteur_robot]) rotate([90,0,0])
	{
		linear_extrude(epaisseur) balise_gd(epaisseur);
	}
	// balise droite
	translate([profondeur_robot/2-cote_support_balise/2,-cote_support_balise/2+epaisseur,hauteur_robot]) rotate([90,0,0])
	{
		linear_extrude(epaisseur) balise_gd(epaisseur);
	}
	// balise adversaire
	translate([(profondeur_robot-cote_support_balise)/2,-cote_support_balise/2,hauteur_support_balise])
		cube([cote_support_balise,cote_support_balise,cote_support_balise]);
}

robot();
//translate([85,0,63/2]) rotate([0,90,0]) cylinder(d=63,h=100);
//translate([200-63/2,0,0]) cylinder(d=63,h=100);