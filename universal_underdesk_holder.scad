width     = 40;
length    = 65;
height    = 10;
thickness = 2;
loose = 0.5;
male = true;
female = true;
$fit = height/2;

module boltHole(){
    cylinder(height,3,3,$fn=20);
    translate([0,0,0-height]) cylinder(h=height*2,r1=1.5,r2=1.5,$fn=20);
} ;

if(female){
    difference(){
        cube([width,length,height],true);
        translate([0,thickness,height/2-$fit]) {
            cube([width-thickness*2,length,$fit],true); 
            translate([0,0,$fit-thickness/2])cube([thickness*2,length,thickness*2],true); 
            translate([width/2-$fit-1,length/2 - $fit -2,0-height/2+1]) boltHole();
            translate([width/2-$fit,0-(length/2 - $fit -1),0-height/2+1]) boltHole();
            translate([0-(width/2-$fit-1),length/2 - $fit -2,0-height/2+1]) boltHole();
            translate([0-(width/2-$fit-1),0-(length/2 - $fit -1),0-height/2+1]) boltHole();
        }
    }
}
if(male){
    cube([(width-thickness*2)-loose*2,length-loose*2,$fit-loose*2],true); 
    translate([0,0,$fit-thickness/2]){
        cube([thickness*2-loose*2,length-loose*2,thickness*2+loose*2],true);
        translate([0,0,$fit-thickness])cube([width,length,2],true);
    }
}