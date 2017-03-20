$fn=100;

module pneu(largeur)
{
	intersection()
	{
		scale([1,1.5,1]) sphere(d=75); //scale au pif
		rotate([90,0,0]) cylinder(d=75+2,h=largeur,center=true);
	}
}

module cone_interne(h_tot,h_trou)
{
	d_int=63;
	d_ext=32;
	d_trou=17;
	rotate([-90,0,0])
		difference()
		{
			// cone
			cylinder(d1=d_int,d2=d_ext,h=h_tot);
			// trou
			translate([0,0,h_tot-h_trou+0.1])
				cylinder(d=d_trou,h=h_trou);
		}
}

module cone_externe(h_tot,d_ext)
{
	d_mid=56;
	d_int=63;
	h_cut=2.5;
	rotate([90,0,0])
	{
		// cone bas
		cylinder(d1=d_int,d2=d_mid,h=h_cut);
		// cone haut
		translate([0,0,h_cut])
			cylinder(d1=d_mid,d2=d_ext,h=h_tot-h_cut);
	}
}

module marque_support(dia)
{
	rotate([90,0,0])
		intersection()
		{
			cube([dia+10,10,1],center=true);
			cylinder(d=dia,h=1,center=true);
		}
}

module marque_texte(txt)
{
	rotate([90,0,0])
		text(txt,size=3.6,
			halign="center",
			valign="center");
}

module axe(h_tot,l_fixation)
{
	d_axe=16;
	d_trou=7;
	h_meplat=42;
	h_offset=-2+(h_tot-h_meplat);
	x_offset=13.3-d_axe/2;
	difference()
	{
		union()
		{
			// cylindre central
			translate([0,0,1.5])
				cylinder(d=d_axe,h=h_tot-2.5);
			// cylindre fixation
			translate([0,0,-l_fixation])
				cylinder(d=10,h=l_fixation+0.5);
			// chanfrein bas
			translate([0,0,0.5])
				cylinder(d1=d_axe-2,d2=d_axe,h=1);
			translate([0,0,h_tot-1])
			// chanfrein haut
				cylinder(d1=d_axe,d2=d_axe-2,h=1);
		}
		// meplat
		translate([x_offset,-d_axe/2,h_offset])
			cube([d_axe,d_axe,h_meplat]);
		// trou interieur
		translate([0,0,-0.1])
			cylinder(d=d_trou,h=h_tot+0.2);
	}
}

module moteur_roue(txt="",align="pneu")
{
	largeur_pneu = 50;
	longueur_axe = 48.5;
	largeur_cone_externe=9.5;
	dia_cone_externe=49;
	largeur_cone_interne=13;
	profondeur_fixation = 3;
	
	decalage= align=="ext"  ? largeur_pneu/2+largeur_cone_externe :
			  align=="int"  ? -largeur_pneu/2-largeur_cone_interne :
			  align=="axe"  ? -largeur_pneu/2-largeur_cone_interne-longueur_axe  :
			  align=="pneu" ? 0 : 0;
	
	translate([0,decalage,0])
	{
		// pneu
		color([0.1,0.1,0.1])
			pneu(largeur_pneu);
		// cone interne
		color([0.86,0.86,1])
			translate([0,largeur_pneu/2,0])
				cone_interne(largeur_cone_interne, profondeur_fixation);
		// cone externe et marque
		translate([0,-largeur_pneu/2,0])
			difference()
			{
				color([0.86,0.86,1])
					cone_externe(largeur_cone_externe,dia_cone_externe);
				translate([0,-largeur_cone_externe+0.49,0])
				{
					color([0,0,0])
						marque_support(dia_cone_externe-2*3);
					color([1,1,1])
						marque_texte(txt);
				}
			}
		// axe
		color([0.2,0.2,0.2])
			translate([0,largeur_pneu/2+largeur_cone_interne,0])
				rotate([0,-90,-90])
					axe(longueur_axe,profondeur_fixation);
	}
}

moteur_roue("Phoenix Robotik","ext");
color([1,0,0])
	translate([0,-140,0])
		rotate([0,0,90])
			text("align=ext",size=20,valign="center");
translate([-80,0,0])
{
	moteur_roue("Phoenix Robotik","pneu");
	color([1,0,0])
	translate([0,-200,0])
		rotate([0,0,90])
			text("align=pneu",size=20,valign="center");
}
translate([-160,0,0])
{
	moteur_roue("Phoenix Robotik","int");
	color([1,0,0])
	translate([0,80,0])
		rotate([0,0,90])
			text("align=int",size=20,valign="center");
}
translate([-240,0,0])
{
	moteur_roue("Phoenix Robotik","axe");
	color([1,0,0])
	translate([0,30,0])
		rotate([0,0,90])
			text("align=axe",size=20,valign="center");
	
}
