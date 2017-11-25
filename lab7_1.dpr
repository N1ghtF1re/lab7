program lab7_1;

{$APPTYPE CONSOLE}
const N=255;
const acceptchars = ['A'..'z', ' '];
const uperCase = ['A'..'Z'];
type
  TStringsArray = array[1..N] of string;
var str:string;
i,newarrN:integer;
LastWord:string;
StrArr:TStringsArray;

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
    if (str[i] in uperCase) then
    begin
      //writeln(str[i]);
      str[i] :=  chr(Ord(str[i]) + 32);
    end;
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

procedure findNeedWords(const str: string; var arr: TStringsArray; blockedword:string; var k: integer);
var nullarr: TStringsArray;
count,maxcount,i,lastpos:byte;
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
      if (count > maxcount) then
      begin
        if(Copy(str,lastpos+1, i-lastpos-1) <> blockedword) then
        begin
          maxcount:=count;
          arr:=nullarr;
          k:=1;
          arr[k]:=Copy(str,lastpos+1, i-lastpos-1);
          inc(k);
        end;
      end
      else
      begin
        if (count = maxcount) then
        begin
          if(Copy(str,lastpos+1, i-lastpos-1) <> blockedword) then
          begin
            arr[k]:=Copy(str,lastpos+1, i-lastpos-1);
          end;
          inc(k);
        end;
      end;
      count:=0;
      lastpos:=i;
      inc(i);
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
      if (count > maxcount) then
      begin
        if(Copy(str,lastpos+1, i-lastpos-1) <> blockedword) then
        begin
          maxcount:=count;
          arr:=nullarr;
          k:=1;
          arr[k]:=Copy(str,lastpos+1, i-lastpos-1);
          inc(k);
        end;
      end
      else
      begin
        if (count = maxcount) then
        begin
          if(Copy(str,lastpos+1, i-lastpos-1) <> blockedword) then
          begin
            arr[k]:=Copy(str,lastpos+1, i-lastpos-1);
          end;
          inc(k);
        end;
      end;
      count:=0;
      lastpos:=i;
      inc(i);
    end;
    inc(i);
  end;
end;

begin
  Writeln('Please, enter string');
  Readln(str);
  repairString(str);
  writeln(str);
  LastWord:= searchLastWord(str);
  //writeln(LastWord);
  newarrN:=1;
  findNeedWords(str, StrArr,LastWord,newarrN);
  for i:=1 to newarrN do
    write(StrArr[i], ' ');
  Readln;
end.
