 
Uses Crt;
Const
 MaxNumbers = 4; 
 Fora = 40;
 Height = 10;
 Width = 30;
type
  myArr = Array [1..MaxNumbers] of Integer;
  matrixStr = Array[0..10, 0..50] of String;
var
  continued: String;
  
// Приветствие  
procedure welcome();  
begin
  textbackground (7);   //Фон будет (серый цвет)
  clrscr;               //Очистка экрана и применении цвета фона
  
  textcolor (0);    //Текст будет 5Фиолетовый
  gotoxy (45,8);    //Курсор в точке по центру экрана (x,y)
  write ('Тренажер для памяти');
  gotoxy (35,11);
  write ('Выводим на экран числа, а Вы запоминаете');
  gotoxy (35,12);
  write ('Воспроизводите каждое число. Для продолжения нажмите "enter"');
  gotoxy (35,13);
  write ('Количество чисел и скорость меняются.');
  gotoxy (35,14);
  write ('Ваша фора = ',fora, ' баллов.' );
  gotoxy (35,15);
  write ('С каждым этапом сложности баллы увеличиваются.' );
  
  gotoxy (35,18);
  Write('Когда будете готовы начать, нажмите "enter" ');
  ReadLn;
  clrscr;        //Очистка экрана
end;  

// Вывод Matrix
procedure outputMatrix(x: matrixStr); 
var
  i,j: byte;
begin
  for i:=1 to Height do begin
    for j:= 1 to Width do
    write(x[i,j]);
  writeln;
  end;
end;

procedure Matrix(znak:byte);
var
  i,j: integer; 
  M: matrixStr;
  st: String;
begin
  for j:= 1 to Width do begin
    M[1][j]:= '-';
    M[Height][j]:= '-';
  end;
  for i:=2 to Height-1 do begin
    for j:= 1 to Width do begin
      M[i][j]:= ' ';
    end;
  if znak = 1 then begin
    M[2][5]:= '☺';
    M[3][10]:= '☺';
    M[2][15]:= '☺';
    M[3][20]:= '☺';
    M[2][25]:= '☺';
  end;
  if znak = 2 then begin
    M[7][4]:= '(☺)';
    M[5][10]:= '☺';
    M[6][15]:= '☺';
    M[5][21]:= '☺';
    M[3][25]:= '(☺)';
  end;
  if znak = 3 then begin
    M[10][3]:= '(☺)';
    M[8][9]:= '(☺)';
    M[9][15]:= '(☺)';
    M[7][22]:= '☺';
    M[9][25]:= '(☺)';
  end;
  
  end;
  outputMatrix(M); 
end;


procedure finish(MaxNumbers, point:Integer; ErrorsA:myArr);
var
  Sum:Real;
  i: integer;
  znak:byte;
begin
 Sum:=0;
 For i:=1 to MaxNumbers do
   Sum:=Sum+ErrorsA[i];
 Sum:=Sum/MaxNumbers;
 WriteLn('Итоговые баллы = ',point);
 WriteLn('Средний процент ошибок в выполненых заданиях = ', Round(sum),'%');
 If Round(sum)< 1 then begin
   WriteLn('Отличная работа. Поздравляем!');
   Matrix(1);
  end;
 If (Round(sum)> 1)and (Round(sum)< 30) then begin
   WriteLn('Вы, хорошо справляетесь. Так держать!');
   Matrix(2);
  end;
 If Round(sum)> 29 then begin
   WriteLn('Вы на верном пути. У Вас все получиться.');
   Matrix(3);
  end;
  
end;

// Защита от дурака
function foolproof():Integer;
var
  st:string;
  x,err:integer;
begin
  repeat
    ReadLn(st);
    val(st, x, err);
    if err <> 0 then WriteLn('Неверный символ, попробуйте еще раз')
  until err =0;
  result:= x ;
end;
 
procedure Trainer();
Var
 Numbers: myArr;  // Для Рандомных чисел
 NumbersUser: myArr;  // для чисел от Пользователя
 ErrorsA: myArr;  // Ошибки для подсчета
 i: Integer;
 TempStr: String;          // текущее число как строка
 S: String;                // строка с числами
 time_reduction: Integer;  // сокращение времени
 CurrN: Integer;           // количество чисел для запоминания
 Errors, Point: Integer;   // Ошибки и быллы
 Point_reduction: Integer; // прирост/потеря баллов
 Diff: Integer;            // из какого диапазона рандом чисел
 Sum: Real;
Begin
 CurrN:=1;      // сколько чисел будем запоминать
 time_reduction:=MaxNumbers*900;
 Diff:=100;
 Point_reduction:= 10;
 Randomize;

 point:=Fora; // начальное число баллов
 While CurrN <= MaxNumbers do begin
   ClrScr;            //очищаем экран 
   TempStr:='';
   S:='';
   for i:=1 to CurrN do begin  // формируем строку из рандомных чисел
     Numbers[i]:=Random(Diff-100, Diff+300);
     Str(Numbers[i],TempStr);
     S:=S+TempStr+'     ';
   end;
   GotoXY(42, 8);
   Writeln(time_reduction div 1000,' секунд на выполнение задания!');
   GotoXY(60-Length(s) div 2, 11);
   Writeln(s);       // вывели задание
   Delay(time_reduction);   // ждем 
   ClrScr;           // очистили экран
   Errors:=0;        // обнуляем ошибку
   
   GotoXY(5,2); 
   WriteLn('Всего нужно ввести чисел: ',CurrN);
   for i:=1 to CurrN do begin
     WriteLn('Введите ',i,' число: ');
     NumbersUser[i]:= foolproof();
   end;
   for i:=1 to CurrN do begin
     if NumbersUser[i]<>Numbers[i] then begin
       inc(Errors);
       point:= point-Point_reduction;
       end
     else point:= point + Point_reduction;
   end;
   
   WriteLn('Ваши баллы на текущий момент: ',point);
   WriteLn('Ошибок допущено: ',Errors);
   ErrorsA[CurrN]:=Round(Errors/CurrN*100);
   WriteLn('Процент допущенных ошибок : ',ErrorsA[CurrN],'%');
   WriteLn('Для перехода на следующий этап нажмите "enter"');
 
   //Увеличиваем количество чисел
   CurrN:=CurrN+1;
   // Уменьшаем время
   time_reduction:=time_reduction-20;
   // Увеличиваем числа 
   Diff:=Diff*2;
   // Увеличиваем прирост баллов
   Point_reduction:=Point_reduction + 10;
   
   ReadLn;
 end;
 
 //ЗАВЕРШЕНИЕ
 finish(MaxNumbers,point, ErrorsA);
 ReadLn;
 clrscr;        //Очистка экрана
end;
 
Begin
 continued:= 'Y';
 welcome();
 while continued = 'Y' do begin
   Trainer();
   gotoxy (35,11);
   WriteLn ('Еще попытка?  Y/N');
   ReadLn(continued);
 end;
 clrscr;        //Очистка экрана
 gotoxy (35,11);
 WriteLn ('До встречи...');
End.
