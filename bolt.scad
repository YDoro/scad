rings = 6;
length = 30;
diammeter = 30;

thread_base_thickness = 5;
thread_width = 0.3;
thread_height = 2;
thread_end_thickness = 0.3;

N = 1000 * 0.1 * diammeter * 0.1 * rings;
module screw(r = rings, l = length, d = diammeter, tb = thread_base_thickness, tw = thread_width, th = thread_height,
             tt = thread_end_thickness)
{
    ANGLE = 360 * r;
    color("lightgray")
    {
        for (i = [0:N])
        {

            hull()
            {
                translate([ d / 2 * cos(i * ANGLE / N), d / 2 * sin(i * ANGLE / N), i * l / N ])
                    rotate(a = 55, v = [ 0, 0, 1 ]) rotate(a = -135 + i * ANGLE / N, v = [ 0, 0, 1 ])
                        rotate(a = 90, v = [ 0, 1, 0 ]) linear_extrude(convexity = 2, height = thread_end_thickness)
                            polygon([ [ -tb / 2, 0 ], [ -tw / 2, th ], [ tw / 2, th ], [ tb / 2, 0 ] ]);

                translate([ d / 2 * cos((i + 1) * ANGLE / N), d / 2 * sin((i + 1) * ANGLE / N), (i + 1) * l / N ])
                    rotate(a = 55, v = [ 0, 0, 1 ]) rotate(a = -135 + i * ANGLE / N, v = [ 0, 0, 1 ])
                        rotate(a = 90, v = [ 0, 1, 0 ]) linear_extrude(convexity = 2, height = thread_end_thickness)
                            polygon([ [ -tb / 2, 0 ], [ -tw / 2, th ], [ tw / 2, th ], [ tb / 2, 0 ] ]);
            }
        }

        translate([ 0, 0, l / 2 ]) cylinder($fn = 100, h = l + 10, d1 = d + 0.2, d2 = d + 0.2, center = true);
    }
}