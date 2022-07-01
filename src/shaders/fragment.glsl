uniform float uTime;
uniform float uProgress;
uniform vec2 mouse;
uniform sampler2D image;
uniform sampler2D displacement;
varying vec3 vPosition;

varying vec2 vUv;

float map(float value,float min1,float max1,float min2,float max2){
    return min2+(value-min1)*(max2-min2)/(max1-min1);
}

void main()
{
    vec4 displace=texture2D(displacement,vUv.yx);
    
    vec2 displacedUv=vec2(vUv.x,vUv.y);
    
    displacedUv.y=mix(vUv.y,displace.r-.2,uProgress);
    
    vec4 color=texture2D(image,displacedUv);
    
    color.r=texture2D(image,displacedUv+vec2(0.,10.*.005)*uProgress).r;
    color.g=texture2D(image,displacedUv+vec2(0.,10.*.01)*uProgress).g;
    color.b=texture2D(image,displacedUv+vec2(0.,10.*.02)*uProgress).b;
    // ///////////////////////////////////////////////////////
    float dist=length(vPosition-vec3(mouse,0.));
    
    float prox=1.-map(dist,0.,.2,0.,1.);
    
    prox=clamp(prox,0.,1.);
    
    // vec2 zoomUv=vUv+direction*prox*prox*progress;
    
    vec2 zoomUv1=mix(vUv,mouse.xy+vec2(.5),prox*uProgress);
    
    vec4 textColor=texture2D(image,zoomUv1);
    
    gl_FragColor=color;
    gl_FragColor=vec4(dist,dist,dist,1.);
    gl_FragColor=textColor;
    
}