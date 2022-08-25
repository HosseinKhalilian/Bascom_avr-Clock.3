'======================================================================='

' Title: LCD Display Clock
' Last Updated :  04.2022
' Author : A.Hossein.Khalilian
' Program code  : BASCOM-AVR 2.0.8.5
' Hardware req. : Atmega16 + 16x2 Character lcd display

'======================================================================='

$regfile = "m16def.dat"
$crystal = 1000000

Config Lcdpin = Pin , Db4 = Portd.4 , Db5 = Portd.5 , Db6 = Portd.6 , _
Db7 = Portd.7 , E = Portd.3 , Rs = Portd.2
Config Lcd = 16 * 2

Config Portb = Input
Config Portd.0 = Output

Declare Sub Minute_i
Declare Sub Minute_d
Declare Sub Hour_i
Declare Sub Hour_d
Declare Sub Main
Dim S As Byte
Dim M As Byte
Dim H As Byte

'-------------------------------------------------

Do

If Pinb.0 = 1 Then Call Minute_i
If Pinb.1 = 1 Then Call Minute_d
If Pinb.2 = 1 Then Call Hour_i
If Pinb.3 = 1 Then Call Hour_d
If Pinb.4 = 1 Then Call Main
Cls
Cursor Off
Locate 1 , 4
Lcd "Enter Time"
Locate 2 , 1
Lcd "Hour=" ; H ; "   Min=" ; M
Waitms 50

Loop

End

'----------------------------------------------

Main:

If Pinb.0 = 1 Then Call Minute_i
If Pinb.1 = 1 Then Call Minute_d
If Pinb.2 = 1 Then Call Hour_i
If Pinb.3 = 1 Then Call Hour_d
Incr S
Waitms 755
Toggle Portd.0
If S > 59 Then
S = 0
Incr M
End If
If M > 59 Then
M = 0
Incr H
End If
If H > 23 Then
H = 0
End If
Cls
Cursor Off
Home
Lcd " CLOCK:"
Locate 2 , 9
Lcd H ; ":" ; M ; ":" ; S

Goto Main

'''''''''''''''''''''''''''

Minute_i:

Incr M
If M > 59 Then
M = 0
End If

Return

'''''''''''''''''''''''''''

Minute_d:

Decr M
If M = 255 Then
M = 59
End If

Return

'''''''''''''''''''''''''''

Hour_i:

Incr H
If H > 23 Then
H = 0
End If

Return

'''''''''''''''''''''''''''

Hour_d:

Decr H
If H = 255 Then
H = 23
End If

Return

'-------------------------------------------------