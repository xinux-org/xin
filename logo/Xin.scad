// SPDX-License-Identifier: GPL-3.0-or-later

// Number of lambdas
num = 6; // [3:25]

// Offset of lambda
foff = [-12, -42];

// Offset after clipping. Use for gaps.
gaps = [24, -1];

// Rotation of each lambda
lrot = 0; // [-180:180]

// Lambda arm angle
larm = 30; // [-180:180]

// Clipping ngon radius
clipr = 92; // [0:300]

// Clipping ngon rotation
cliprot = 0;  // [-180:180]

// Lambda thickness
thick = 20; // [5:30]

// Colors to use
colors = ["#5277c3", "#7caedc"];

// Inverse clipping order
invclip = false;

// Copied from <MCAD/regular_shapes.scad> so customizer will work on thingieverse
module regular_polygon(sides, radius)
{
    function dia(r) = sqrt(pow(r*2,2)/2);  //sqrt((r*2^2)/2) if only we had an exponention op
    angles=[ for (i = [0:sides-1]) i*(360/sides) ];
    coords=[ for (th=angles) [radius*cos(th), radius*sin(th)] ];
    polygon(coords);
}

// Draw a lambda
module lambda() {
    union() {
        rotate(-larm) translate([0,-25,0]) cube([thick,50,10], center=true);
        rotate(larm) cube([thick,100,10], center=true);
    }    
}

// Generates lambda and subtracts next lambda from it
module diff(nextangle) {
    difference() {
        children();
        scale([1,1,2]) rotate(invclip ? nextangle : -nextangle ) children();
    }
}

module clipper(){
    // That's not as easy to autotune as it would seem
    intersection() {
        children();
        rotate(cliprot) linear_extrude(20,center=true) regular_polygon(num, clipr);
    }    
}

// Render the logo!

// Just do that N times
for (r=[0:num])

// Color it with next color in array
color(colors[r % len(colors)])

// Flatten before coloring
projection(cut=true)

// Final rotation, putting lambda in place
rotate(360/num*r)
translate(gaps)

// Clip the edges
clipper()

// Cutting it up with the same lambda at the next place
diff(360/num)

// Translation to endpoint
translate(foff)

// Initial in-place rotation
rotate(lrot)
lambda();
