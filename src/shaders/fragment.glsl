uniform float uTime;
uniform float uProgress;
uniform sampler2D image;
uniform sampler2D displacement;

varying vec2 vUv;

void main()
{
    vec4 displace=texture2D(displacement,vUv.yx);
    
    vec2 displacedUv=vec2(vUv.x,vUv.y);
    
    displacedUv.y=mix(vUv.y,displace.r-.2,uProgress);
    
    vec4 color=texture2D(image,displacedUv);
    
    color.r=texture2D(image,displacedUv+vec2(0.,10.*.005)*uProgress).r;
    color.g=texture2D(image,displacedUv+vec2(0.,10.*.01)*uProgress).g;
    color.b=texture2D(image,displacedUv+vec2(0.,10.*.02)*uProgress).b;
    
    gl_FragColor=color;
}