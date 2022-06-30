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
    
    gl_FragColor=vec4(vUv,1.,1.);
}