program lab7;

{$APPTYPE CONSOLE}
const N=255;
const acceptchars = ['A'..'z', ' '];
const uperCase = ['A'..'Z'];
const vowels = ['a','e','u','i','o'];
type
  TStringsArray = array[1..N] of string;
var str:string;

function toDownCase(str:string):string;
var i:byte;
begin
  for i:=1 to Length(str) do
  begin
    if (str[i] in uperCase) then
    begin
      //writeln(str[i]);
      str[i] :=  chr(Ord(str[i]) + 32);
    end;
    toDownCase:=str;
  end;
end;

function searchLastWord(var str: string):string;
var i:integer;
begin
  i:=Length(str);
  while(str[i] <> ' ') do
    Dec(i);
  searchLastWord:= copy (str,i+1,Length(str) );
end;

procedure repairString(var str:string);
var i,N:integer;
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
        if(((str[i] = ' ') and (str[i+1] = ' ')) or (not (str[i] in acceptchars)))
        then
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

procedure findNeedWords(var str: string; var arr: TStringsArray; var k: integer);
var nullarr: TStringsArray;
count,maxcount,lastpos:byte;
i:integer;
procedure compString;
begin
  if (count > maxcount) then
  begin
    maxcount:=count;
    arr:=nullarr;
    k:=1;
    arr[k]:=Copy(str,lastpos+1, i-lastpos-1);
    Delete(str,i-length(arr[k]), length(arr[k])+1);
    i:=i-length(arr[k])-1;
    inc(k);
  end
  else
  begin
    if (count = maxcount) then
    begin
      arr[k]:=Copy(str,lastpos+1, i-lastpos-1);
      Delete(str,i-length(arr[k]), length(arr[k])+1);
      i:=i-length(arr[k])-1;
      inc(k);
    end;
  end;
  count:=0;
  lastpos:=i;
  inc(i);
end;

begin
  nullarr:=arr;
  maxcount:=1;
  k:=1;
  lastpos:=0;
  count:=0;
  i:=2;
 // for i:=2 to Length(str) do
  while(i <= Length(str)) do
  begin
    if(str[i] > str[i-1]) then
      Inc(count)
    else
    begin
      if(pos(' ', copy(str,i,length(str)-i)) <> 0) then
        i:=pos(' ', copy(str,i,length(str)-i))+i-1;
       // count:=0;
    end;
    if (str[i] = ' ') then
    begin
      compString;
    end;
    inc(i);
  end;
  i:=2;
  lastpos:=0;
  count:=0;
 // for i:=2 to Length(str) do
  while(i <= Length(str)) do
  begin
    if((str[i] < str[i-1]) and (str[i] <> ' ')) then
      Inc(count)
    else
    begin
      if(pos(' ', copy(str,i,length(str)-i)) <> 0) then
        i:=pos(' ', copy(str,i,length(str)-i))+i-1;
    end;
    if (str[i] = ' ') then
    begin
      compString;
    end;
    inc(i);
  end;
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

procedure p1(str:string);
var i,newarrN:integer;
LastWord:string;
StrArr:TStringsArray;
begin
  str:=toDownCase(str);
  writeln(str);
  newarrN:=1;
  findNeedWords(str, StrArr,newarrN);
  Writeln('Point 1:');
  for i:=1 to newarrN do
    write(StrArr[i], ' ');
  Writeln;
end;

procedure p2(str:string);
begin
  getFinalFormating(str);
  Writeln('Point 2:');
  writeln(str);
end;

begin
  repeat
    Writeln('Please, enter string');
    Readln(str);
    repairString(str);
  until(Pos(' ', str) <> 0);
  deleteUtilWord(str);
  repairString(str);
  str:=str+' ';
  p1(str);
  p2(str);
  Readln;
end.
