uses graphabc;

const
  Modul=15; //модуль шестеренки
var
  p:picture;
  name:string;

procedure drawZub(x,y,k:integer; angleDeg:real);
var x0,y0,x1,y1:integer;
  angle:real;
begin
  setpixel(x,y,clred);
  angle:=({360-}angleDeg)*pi/180;
  x0:=x-round(sin(angle)*k/2);
  y0:=y+round(cos(angle)*k/2);
  x1:=x0+round(cos(angle)*k);
  y1:=y0+round(sin(angle)*k);
  p.line(x0,y0,x1,y1);
  x0:=x1;
  y0:=y1;
  x1:=x0+round(sin(angle)*k);
  y1:=y0-round(cos(angle)*k);
  p.line(x0,y0,x1,y1);
  x0:=x1;
  y0:=y1;
  x1:=x0-round(cos(angle)*k);
  y1:=y0-round(sin(angle)*k);
  p.line(x0,y0,x1,y1);
end;

procedure drawWhole(x,y,k:integer;m,ang0:real);
var r,l,ang1,ang:real;

begin
  ang:=360-ang0;
  r:=(k*m/2-(k/2))*0.7;
  p.circle(x,y,round(r));
  p.circle(x,y,round(m/2));
  for var n:=0 to k-1 do
  begin
    l:=r;
    ang1:=(360/k*n+ang)*pi/180;
    drawzub(x+round(cos(ang1)*l),y+round(sin(ang1)*l),modul,(360/k*n+ang));
  end;
   p.Draw(0,0);
end;

function newAng(k:integer;ang:real):real;
var angpart,max:real;
  now:integer;
  done:boolean;
begin
  angpart:=360/k;
  done:=true;
  while done do
  begin
    if max > abs(180-now*angpart) then
    begin
      done:=false;
      result:=now*angpart;
    end
    else
    begin
      max:=abs(180-now*angpart);
      now +=1;
    end;
  end;
  result +=angpart/2; 
  //result +=angpart*random(-1,1);
  result +=ang;
  
  result +=(k div 3)*angpart;
  if result >360 then result -=360;
end;

function CanOn(n:integer):boolean;
begin
  if n=3 then
    result:=true
  else
    result:=false;
end;

procedure drawChain(x,y,k,n,maxk,minK:integer;ang0:real);
var l,ang1:real;
  newk:integer;
  nStr:string;
begin

    drawwhole(x,y,k,modul,ang0);
    if canon(n-1) then
      newk:=maxk
    else
      newk:=random(mink,maxk);
    
    l:=((k*modul/2-(k/2))*0.7)+((newk*modul/2-(newk/2))*0.7)+1.4*modul;
    ang1:=newang(k,ang0);
    nStr:=inttostr(n);
    setfontsize(modul);
    p.TextOut(x+modul,y-2*modul,nstr);
  
  if n<>1 then
  begin
  if canon(n) then
  begin
    p.TextOut(x+((2*k*modul) div (10)),y-((2*k*modul) div (10)),nstr);
    drawchain(x,y,random(mink,(mink+k)div 2),n-1,mink,k,180+ang1);
  end
  else
    drawchain(x+round(cos(ang1*pi/180)*l),y-round(sin(ang1*pi/180)*l),newk,n-1,maxk,mink,180+ang1);
  end;
end;

begin
 p:= new Picture(1500,1500);
 pen.Width:=3;//modul div 25;
 // drawWhole(p.Width div 2,p.Height div 2,10,modul,45);
for var n:=1 to 20 do
begin
  drawchain(750,750,10,7,28,8,0);
  name:='test_chain_'+inttostr(n)+'.png';
  p.save(name);
  //p.Clear();
  p:= new Picture(1500,1500);
end;
end.