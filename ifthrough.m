function[x3,angle4]=ifthrough(a,L1,n1,n2,x0,y0,k1,ang1)%Whether or not the outgoing light passes through the small hole

k2=2*a*x0;%Slope tangent to the point of incidence
    
        angle0=atan((k2-k1)/(1+k1*k2));%Angle between incident light and tangent
        a0=rad2deg(angle0);
        angle1=(pi/2)-angle0;%Angle between incident light and normal
        angle2=2*angle1;%Angle of incident light to outgoing light
        ang4=ang1-angle2;%Angle between the outgoing light and M2
        k3=tan(ang4);%Slope of emitted light
        b=y0-k3*x0;%optical cut-off distance of the projected light
        x2=-b/k3;%Intersection of the outgoing light with M2
        ang5=abs(atan(k3));%Back to the 0-90 range

        angle4=pi/2-ang5;%Angle between the outgoing light and the direction of perpendicular incidence M2
        angle3=asin(abs((n1*sin(angle4))/n2));%Find the angle of refraction from the air cavity to the sic cavity3

        if a0<=0
            x3=x2+tan(angle3)*L1;%Intersection with M1, change of direction of reflection, change of sign.
        else
            x3=x2-tan(angle3)*L1;
        end   

end