unit u_unlock_new_algo;

interface

implementation

procedure decrypt(in_buf:pbytearray);
const
 sec = '$EcUre-W@|1p@PeR';
var
 file_buf : TMemoryStream;
 buf, tmp_buf : array of Byte;
 ctx : TAESContext;
 IV  : TAESBlock;
 size, i : Integer;
 str : String;
begin
if OpenDialog.Execute then
 begin
  file_buf:=TMemoryStream.Create;
  file_buf.LoadFromFile(OpenDialog.FileName);

  //Memo1.Lines.Add('Decrypt: '+ExtractFileName(OpenDialog.FileName));

  file_buf.Read(key[0],16);

  str:='Key: ';
  for i:=0 to 15 do
   str:=str + IntToHex(key[i],2) + ' ';
  //Memo1.Lines.Add(str);

  size:=file_buf.Size - $20;

  file_buf.Position:=$14;
  SetLength(buf,size);
  SetLength(tmp_buf,16);
  file_buf.Read(buf[0],size);

  MD5.Init;
  MD5.Update(buf[0],size);
  FillChar(tmp_buf[0],$10,0);
  MD5.Final(tmp_buf[0]);

  if CompareMem(@tmp_buf[0], @key[0], 16) then
    begin
      //Memo1.Lines.Add('Detected uncrypted type!');
      file_buf.SetSize(0);
      file_buf.Write(buf[0],Length(buf));
      str:=OpenDialog.FileName;
      i:=Length(str)-1;
      while ((str[i] <> '.') and (i > 0)) do
       Dec(i);
      if i = 1 then
       str:=str + '_ud'
      else
       Insert('_ud',str,i);
      file_buf.SaveToFile(str);
      //Memo1.Lines.Add('File '+ExtractFileName(str)+' saved!');
    end
  else
   begin
    file_buf.Position:=$14;
    SetLength(buf,size);
    SetLEngth(tmp_buf,size);
    file_buf.Read(buf[0],size);

    Move(sec[1], IV[0], 16);
    AES_CBC_Init_Decr(key, $80, IV, ctx);
    AES_CBC_Decrypt(@buf[0], @tmp_buf[0], size, ctx);

    MD5.Init;
    MD5.Update(tmp_buf[0],size);
    FillChar(buf[0],$10,0);
    MD5.Final(buf[0]);

    if CompareMem(@buf[0], @key[0], 16) then
     begin
      //Memo1.Lines.Add('Detected crypted type 1!');
      file_buf.SetSize(0);
      file_buf.Write(tmp_buf[0],Length(tmp_buf));
      str:=OpenDialog.FileName;
      i:=Length(str)-1;
      while ((str[i] <> '.') and (i > 0)) do
       Dec(i);
      if i = 1 then
       str:=str + '_d1'
      else
       Insert('_d1',str,i);
      file_buf.SaveToFile(str);
      //Memo1.Lines.Add('File '+ExtractFileName(str)+' saved!');
     end
    else
     begin
       file_buf.Position:=0;
       SetLength(tmp_buf,20);
       file_buf.Read(tmp_buf[0],20);
       FillChar(key[0],16,0);
       MakeXKey(tmp_buf, key);

       file_buf.Position:=$14;
       SetLength(buf,size);
       SetLEngth(tmp_buf,size);
       file_buf.Read(buf[0],size);

       Move(sec[1], IV[0], 16);
       AES_CBC_Init_Decr(key, $80, IV, ctx);
       AES_CBC_Decrypt(@buf[0], @tmp_buf[0], size, ctx);

       SHA1.Init;
       SHA1.Update(tmp_buf[0],size);
       FillChar(buf[0],$14,0);
       SHA1.Final(buf[0]);

       PutHex4(buf,0,ReadHex4(buf,0));
       PutHex4(buf,4,ReadHex4(buf,4));
       PutHex4(buf,8,ReadHex4(buf,8));
       PutHex4(buf,$C,ReadHex4(buf,$C));
       PutHex4(buf,$10,ReadHex4(buf,$10));

       file_buf.Position:=0;
       file_buf.Read(buf[$14],$14);

       if CompareMem(@buf[0], @buf[$14], 20) then
        begin
         //Memo1.Lines.Add('Detected crypted type 2!');
         file_buf.SetSize(0);
         file_buf.Write(tmp_buf[0],Length(tmp_buf));
         str:=OpenDialog.FileName;
         i:=Length(str)-1;
         while ((str[i] <> '.') and (i > 0)) do
          Dec(i);
         if i = 1 then
          str:=str + '_d2'
         else
          Insert('_d2',str,i);
         file_buf.SaveToFile(str);
         //Memo1.Lines.Add('File '+ExtractFileName(str)+' saved!');
        end
       else
        begin
         //Memo1.Lines.Add('Unknown file type!');
         file_buf.SetSize(0);
         file_buf.Write(tmp_buf[0],Length(tmp_buf));
         str:=OpenDialog.FileName;
         i:=Length(str)-1;
         while ((str[i] <> '.') and (i > 0)) do
          Dec(i);
         if i = 1 then
          str:=str + '_unk'
         else
          Insert('_unk',str,i);
         file_buf.SaveToFile(str);
         //Memo1.Lines.Add('File '+ExtractFileName(str)+' saved!');
        end;
     end;
   end;
  //Memo1.Lines.Add('');

  file_buf.Free;
 end;
end;

end.
