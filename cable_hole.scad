use <bolt.scad>
hole_radius = 40;
border_width = 4;
border_height = 2;
table_thickness = 30;
wall_thickness = 2;
male = true;
female = true;
screwed = false;
clip = true;
inner_radius = hole_radius - wall_thickness;
overflow = 0.1;

module _screwed(loose = 0) screw(r = 2, l = (table_thickness / 4), d = hole_radius * 2 - wall_thickness * 2 + loose * 2,
                                 tb = 1.5 + loose, tw = 0.5 + loose, th = 1.5 + loose, tt = 0.5 + loose);

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
        if (screwed)
        {
            translate([ 0, 0, 0 - table_thickness / 2 - border_height / 2 ]) _screwed();
        }
        else
        {
            if (clip)
            {
                translate([ 0, inner_radius - wall_thickness, 0 - table_thickness / 2 + wall_thickness ]) color("red")
                    cube(size = wall_thickness * 2);
                translate([ 0, 0 - inner_radius - wall_thickness, 0 - table_thickness / 2 + wall_thickness ])
                    color("red") cube(size = wall_thickness * 2);
            }
        }
    }
}

if (male)
{
    difference()
    {
        translate([ 0, 0, 0 - border_height ]) union()
        {
            if (screwed)
            {
                translate([ 0, 0, 0 - table_thickness / 3 ]) _screwed(loose = 0.1);
            }
            else
            {
                if (clip)
                {
                    translate([ 0, inner_radius - wall_thickness, 0 - table_thickness / 2 + border_height * 1.75 ])
                    {
                        translate([ 0, 0, wall_thickness ])
                            cube([ wall_thickness * 2 - overflow, wall_thickness * 2 - overflow, wall_thickness ]);
                        translate([ 0, 0, 0 - wall_thickness ])
                            cube([ wall_thickness * 2 - overflow, wall_thickness / 1.5, wall_thickness * 4 ]);
                    }
                    translate([ 0, 0 - inner_radius - wall_thickness, 0 - table_thickness / 2 + border_height * 1.75 ])
                    {
                        translate([ 0, 0, wall_thickness ])
                            cube([ wall_thickness * 2 - overflow, wall_thickness * 2 - overflow, wall_thickness ]);
                        translate([ 0, (wall_thickness - overflow * 3) * 1.5, 0 - wall_thickness ])
                            cube([ wall_thickness * 2 - overflow, wall_thickness / 1.5, wall_thickness * 4 ]);
                    }
                }
            }
            translate([ 0, 0, 0 - table_thickness / 2 ]) cylinder(h = border_height, r = hole_radius + border_width);
        }
        translate([ 0, 0, 0 - table_thickness + border_height ])
            cylinder(h = border_height * 1.75, r = hole_radius + border_width);

        cylinder(h = table_thickness * 2, r = inner_radius - wall_thickness, center = true);
    }
}