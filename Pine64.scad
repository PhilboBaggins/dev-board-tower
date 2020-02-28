$fn = 64;

PINE_64_SIZE = [127, 79];
PINE_64_SCREW_RADIUS = 3.5 / 2;
PINE_64_SCREW_OFFSET = 2.5 + PINE_64_SCREW_RADIUS;
PINE_64_PCB_THICKNESS = 1;

// TODO: Consider replacing this with RoundedRect2D from github.com:PhilboBaggins/openscad-common.git
module RoundedCornerBox_2D(size, cornerRadius)
{
    x1 =           cornerRadius;
    x2 = size[0] - cornerRadius;
    y1 =           cornerRadius;
    y2 = size[1] - cornerRadius;

    hull()
    {
        translate([x1, y1]) circle(r=cornerRadius);
        translate([x2, y1]) circle(r=cornerRadius);
        translate([x1, y2]) circle(r=cornerRadius);
        translate([x2, y2]) circle(r=cornerRadius);
    }
}

module RoundedCornerBox_3D(size, cornerRadius, thickness)
{
    linear_extrude(thickness)
    RoundedCornerBox_2D(size, cornerRadius);
}

module Pine64_2D()
{
    screwX1 = PINE_64_SIZE[0] * 0 + PINE_64_SCREW_OFFSET;
    screwX2 = PINE_64_SIZE[0] * 1 - PINE_64_SCREW_OFFSET;
    screwY1 = PINE_64_SIZE[1] * 0 + PINE_64_SCREW_OFFSET;
    screwY2 = PINE_64_SIZE[1] * 1 - PINE_64_SCREW_OFFSET;

    difference()
    {
        RoundedCornerBox_2D(PINE_64_SIZE, PINE_64_SCREW_RADIUS * 2);

        translate([screwX1, screwY1]) circle(r=PINE_64_SCREW_RADIUS);
        translate([screwX2, screwY1]) circle(r=PINE_64_SCREW_RADIUS);
        translate([screwX1, screwY2]) circle(r=PINE_64_SCREW_RADIUS);
        translate([screwX2, screwY2]) circle(r=PINE_64_SCREW_RADIUS);
    }
}

module Pine64_3D()
{
    linear_extrude(PINE_64_PCB_THICKNESS)
    Pine64_2D();
}

Pine64_3D();
