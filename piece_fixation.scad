use <moteur_roue.scad>

angle=35;
profondeur=13.5;
largeur_ouverture=16/cos(angle)+10*tan(angle);
largeur_fond=largeur_ouverture-2*profondeur/tan(90-angle);
marge=10;
marge_prof=15;
dia_trou=5;
echo(largeur_ouverture);
echo(largeur_fond);
echo(largeur_ouverture+2*marge);
echo(profondeur+marge_prof);

ecart_moteurs=20;
longueur_meplat=42;
d_chanfrein=10;

module piece_fixation(longueur)
{
	echo(longueur);
	echo(largeur_ouverture+2*marge);
	translate([0,-longueur/2,0])
	rotate([90,0,180])
	linear_extrude(longueur)
		polygon([[-largeur_ouverture/2,profondeur],
				[-largeur_fond/2,0],
				[largeur_fond/2,0],
				[largeur_ouverture/2,profondeur],
				[largeur_ouverture/2+marge,profondeur],
				[largeur_ouverture/2+marge,-marge_prof+d_chanfrein],
				[largeur_ouverture/2+marge-d_chanfrein,-marge_prof],
				[-largeur_ouverture/2-marge+d_chanfrein,-marge_prof],
				[-largeur_ouverture/2-marge,-marge_prof+d_chanfrein],
				[-largeur_ouverture/2-marge,profondeur]],
				[[0,1,2,3,4,5,6,7,8,9]]);
}

difference()
{
	translate([0,0,-profondeur+(13-16/2)])
		piece_fixation(2*longueur_meplat+ecart_moteurs);
	color([1,0,0])
	{		
		translate([(largeur_ouverture+marge)/2,(ecart_moteurs+longueur_meplat)/2,0])
			cylinder(d=dia_trou,h=100,center=true);
		translate([-(largeur_ouverture+marge)/2,(ecart_moteurs+longueur_meplat)/2,0])
			cylinder(d=dia_trou,h=100,center=true);
		
		translate([(largeur_ouverture+marge)/2,-(ecart_moteurs+longueur_meplat)/2,0])
			cylinder(d=dia_trou,h=100,center=true);
		translate([-(largeur_ouverture+marge)/2,-(ecart_moteurs+longueur_meplat)/2,0])
			cylinder(d=dia_trou,h=100,center=true);
	}
	color([0,1,0])
	{		
		translate([(largeur_ouverture+marge)/2,(ecart_moteurs+longueur_meplat)/2,0])
			cylinder(d=dia_trou,h=100,center=true);
		translate([-(largeur_ouverture+marge)/2,(ecart_moteurs+longueur_meplat)/2,0])
			cylinder(d=dia_trou,h=100,center=true);
		
		translate([(largeur_ouverture+marge)/2,-(ecart_moteurs+longueur_meplat)/2,0])
			cylinder(d=dia_trou,h=100,center=true);
		translate([-(largeur_ouverture+marge)/2,-(ecart_moteurs+longueur_meplat)/2,0])
			cylinder(d=dia_trou,h=100,center=true);
	}
}

translate([0,-ecart_moteurs/2,0])		
	translate([0,2,0])
		moteur_roue(align="axe");
translate([0,ecart_moteurs/2,0])
	rotate([0,0,180]) translate([0,2,0])
		moteur_roue(align="axe");