function printMiniAxes(p,Matrix)
eje_x = p + Matrix(1:3,1);
eje_y = p + Matrix(1:3,2);
eje_z = p + Matrix(1:3,3);
line([p(1) eje_x(1)],[p(2) eje_x(2)],[p(3) eje_x(3)],'color',[1 0 0],'linewidth',4);
line([p(1) eje_y(1)],[p(2) eje_y(2)],[p(3) eje_y(3)],'color',[0 1 0],'linewidth',4);
line([p(1) eje_z(1)],[p(2) eje_z(2)],[p(3) eje_z(3)],'color',[0 0 1],'linewidth',4);
end


