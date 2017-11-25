program lab7_2;

{$APPTYPE CONSOLE}
const vowels = ['a','e','u','i','o'];
const acceptchars = ['A'..'z', ' '];
var str:string;

procedure repairString(var str:string);
var i,N:byte;
begin
  n:=Length(str);
  i:=1;
  while(i <= N) do
  begin
    if(str[1] = ' ') then
    begin
      Delete(str,1,1);
      Dec(N);
    end
    else
    begin
      if(str[N] = ' ') then
      begin
        Delete(str,n,1);
        Dec(N);
      end
      else
      begin
        if(((str[i] = ' ') and (str[i+1] = ' ')) or (not(str[i] in acceptchars))) then
        begin
          Delete(str,i,1);
          Dec(N);
        end
        else
          Inc(i);
      end;
    end;
  end;
end;

function toDownCase(str:string):string;
var i:byte;
begin
  for i:=1 to Length(str) do
  begin
    if ((str[i] <= 'Z') and (str[i] >= 'A')) then
    begin
      //writeln(str[i]);
      str[i] :=  chr(Ord(str[i]) + 32);
    end;
    toDownCase:=str;
  end;
end;

function searchLastWord(var str: string):string;
var i:byte;
begin
  i:=Length(str);
  while(str[i] <> ' ') do
    Dec(i);
  searchLastWord:= copy ( str,i+1,Length(str) );
end;

procedure deleteUtilWord(var str:string);
var lastword, dcstr:string;
isEnd:Boolean;
position:byte;
diff:Byte;
begin
  dcstr:=toDownCase(str);
  lastword:= searchLastWord(dcstr);
  isEnd:=false;
  diff:=0;
  while(not isEnd) do
  begin
    position:=pos(lastword, dcstr);
    if(position <> 0) then
    begin
      if (((dcstr[position-1] = ' ') or (dcstr[position-1] = '')) and
       ((dcstr[position+length(lastword)] = ' ') or (dcstr[position+length(lastword)] = '')))
      then
      begin
        Delete(str, position+diff*length(lastword), Length(lastword));
        Delete(dcstr, position, Length(lastword));
      end
      else
      begin
        Delete(dcstr, position, Length(lastword));
        inc(diff);
      end;
    end
    else
      isEnd:=True;
  end;
end;

procedure getFinalFormating(var str:string);
var i,j, lastindex,count:byte;
begin
  i:=1;
  lastindex:=0;
  count:=0;
  while(i <= Length(str)) do
  begin
    if (str[i] <> ' ') then
    begin
      Inc(count);
    end
    else
    begin
      if (not Odd(count)) then
      begin
        for j:=lastindex+1 to i-1 do
        begin
          if (str[j] in Vowels) then
            str[j]:=UpCase(str[j]);
        end;
      end;
      count:=0;
      lastindex:=i;
    end;
    inc(i);
  end;
end;

begin
  Writeln('Please, enter string');
  Readln(str);
  repairString(str);
  //writeln(str);
  deleteUtilWord(str);
  repairString(str);
  str:=str+' ';
  getFinalFormating(str);
  writeln(str);
  Readln;
end.
