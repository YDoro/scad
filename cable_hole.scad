use <bolt.scad>
hole_radius = 25;
border_width = 4;
border_height = 2;
table_thickness = 15;
wall_thickness = 2;
male = true;
female = true;

inner_radius = hole_radius - wall_thickness;
overflow = 0.1;

module _screwed() screw(r = 2, l = (table_thickness / 4), d = hole_radius * 2 - wall_thickness * 2, tb = 1.5, tw = 0.5,
                        th = 1.5, tt = 0.5);

if (female)
{
    difference()
    {
        difference()
        {
            cylinder(h = table_thickness + border_height, r = hole_radius + border_width, $fn = 40, center = true);
            cylinder(h = table_thickness + border_height + overflow, r = inner_radius, $fn = 40, center = true);
            translate([ 0, 0, 0 - border_height ]) difference()
            {
                cylinder(h = table_thickness, r = hole_radius + border_width + overflow, $fn = 40, center = true);
                cylinder(h = table_thickness, r = hole_radius, $fn = 40, center = true);
            };
        }
        translate([ 0, 0, 0 - table_thickness / 2 - border_height / 2 ]) scale([ 1.01, 1.01, 1.01 ]) _screwed();
    }
}
if (male)
{
    difference()
    {
        translate([ 0, 0, 0 - border_height ]) union()
        {
            translate([ 0, 0, 0 - table_thickness / 3 ]) _screwed();
            translate([ 0, 0, 0 - table_thickness / 2 ]) cylinder(h = border_height, r = hole_radius + border_width);
        }
        translate([ 0, 0, 0 - table_thickness + border_height ])
            cylinder(h = border_height * 1.75, r = hole_radius + border_width);

        cylinder(h = table_thickness * 2, r = inner_radius - wall_thickness, center = true);
    }
}