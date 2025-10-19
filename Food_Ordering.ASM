.MODEL SMALL
.STACK 100h
.DATA
    ; Declare strings and variables
    MENU_ONE                DB        13, 10, "		   WELCOME TO OUR KENTUCKY STORE!"
                            DB        13, 10, "	       ====================================="
                            DB        10, 13, "			1. REGISTER"
                            DB        10, 13, "  			2. LOGIN"
                            DB        10, 13, "  			3. EXIT"
                            DB        10, 13, "		      Enter 1-3 ONLY: $", 0
    SEL                     DB        0
    REGNAME                 DB        8 DUP (0)
    REGPASSWORD             DB        8 DUP (0)
    CONFIRMPASSWORD         DB        8 DUP (0)
    LOGINNAME               DB        8 DUP (0)
    LOGINPASSWORD           DB        8 DUP (0)
    LOGIN_COUNT             DB        0
                            PARA_LIST LABEL BYTE
    MAX_LEN                 DB        20
    ACT_LEN                 DB        ?
    INPUT_DATA              DB        20 DUP ("$")
    INPUT_DATA1             DB        20 DUP ("$")
    MSGRN                   DB        13, 10, "	------------------------------------------------------------"
                            DB        13, 10, "	YOU CAN ONLY ENTER A MAXIMUM OF 20 CHARACTERS FOR EACH FIELD"
                            DB        13, 10, "	------------------------------------------------------------"
                            DB        13, 10, "			REGISTER NAME:	   $", 0
    MSGRP                   DB        13, 10, "			REGISTER PASSWORD: $", 0
    MSGCP                   DB        13, 10, "			CONFIRM PASSWORD:  $", 0
    MSGLN                   DB        13, 10, "			LOGIN NAME:	  $", 0
    MSGLP                   DB        13, 10, "			LOGIN PASSWORD:	  $", 0
    IMSG                    DB        13, 10, " 		        --ACCESS DENIED!--"
                            DB        13, 10, " 	 --YOU HAVE ENTERED THE INCORRECT LOGIN DETAILS--$", 0
    VMSG                    DB        13, 10, " 		        --ACCESS GRANTED!--$", 0
    REGSUCCESS              DB        13, 10, " 		   --REGISTRATION SUCCESSFUL!--$", 0
    ERROR_FAIL              DB        13, 10, "	YOU HAVE EXCEEDED THE AMOUNT OF TRIALS, EXITING PROGRAM.$", 0
    ERROR_CONFIRM           DB        13, 10, "	YOU HAVE ENTERED THE INCORRECT PASSWORD, TRY AGAIN.$", 0
    
    ; Variable for the first menu
    FIRST_MENU              DB        13, 10, "		>>> MENU SELECTION FOR YOUR MEAL!! <<< "
                            DB        13, 10, "		    WHICH SELECTION YOU WISH TO GO?"
                            DB        13, 10, "		    1. PICKUP   "
                            DB        13, 10, "		    2. TAKEAWAY"
                            DB        13, 10, "		     -->  $", 0
            
    ; Second menu
    SECOND_MENU             DB        13, 10, "		>>> WELCOME TO OUR SECOND MENU <<<"
                            DB        13, 10, "		   1. FAMILY STYLE BUCKET"
                            DB        13, 10, "		   2. MEAL PLATE"
                            DB        13, 10, "		   3. ALA CARTE"
                            DB        13, 10, "		   4. EXIT"
                            DB        13, 10, "		      -->$", 0

    SECOND_MENU2            DB        13, 10, "		>>> WELCOME TO ADD ON MENU <<<"
                            DB        13, 10, "		   1. Chicken Tender"
                            DB        13, 10, "		   2. Steamed Rice "
                            DB        13, 10, "		   3. French Fries"
                            DB        13, 10, "		      -->$", 0

    GOTOPAGE                DB        0
    MCDPC_COUNT             DB        0
    FAMILY_BUCKET           DB        13, 10, "		==================================="
                            DB        13, 10, "		| 15 Chicken of your choices!     |"
                            DB        13, 10, "		| Come with 4 Potato mashes!      |"
                            DB        13, 10, "		| 4 Coleslaw!                     |"
                            DB        13, 10, "		| 2 pepsi bottle!                 |"
                            DB        13, 10, "		| 3 Cheesy wedges!                |"
                            DB        13, 10, "		| 1 bucket of rice                |"
                            DB        13, 10, "		| Total price per order : RM74.99 |"
                            DB        13, 10, "		===================================  $"
    FAMILY_BUCKET_PRICE     DW        7499                                                                                       ; Price in cents (RM74.99)
    QUANTITY                DW        0
    QUANTITY1               DW        0
    TOTAL_PRICE_INT         DW        0
    TOTAL_PRICE_FRAC        DW        0
    MSGQTY                  DB        13, 10, "		 Enter quantity: $", 0
    MSGTOTAL                DB        13, 10, "		 Total price for your order is RM $", 0
    CENTS_BUFFER            DB        2 DUP (0)                                                                                  ; Buffer to store the fractional part (cents)
    FAMILY_RESULT           DB        0
    TOTAL_PRICE_HIGH        DW        0
    DISPLAY_NUMBER          DW        0
    MEAL_PLATE              DB        13, 10, "		==================================="
                            DB        13, 10, "		| 2 Chicken of your choices!      |"
                            DB        13, 10, "		| Come with 1 rice                |"
                            DB        13, 10, "		| Come with 1 drinks              |"
                            DB        13, 10, "		| Total price per order : RM15.99 |"
                            DB        13, 10, "		=================================== $", 0
    MEAL_PLATE_PRICE        DW        1599                                                                                       ; Price in cents (RM15.50)

    ; A La Carte details
    ALA_CARTE               DB        13, 10, "		==================================="
                            DB        13, 10, "		| Choose your favorite items!     |"
                            DB        13, 10, "		| Select drinks, side dishes,     |"
                            DB        13, 10, "		| and desserts as you like!       |"
                            DB        13, 10, "		| Total price per item: RM7.30    |"
                            DB        13, 10, "		=================================== $", 0
    ALA_CARTE_PRICE         DW        730                                                                                        ; Price in cents (RM7.30)
    ; Define the message for invalid selections
    INVALID_SELECTION_MSG   DB        13, 10, "		INVALID SELECTION! PLEASE CHOOSE A VALID OPTION (1-4).$", 0
    INVALID_SELECTION_MSG1  DB        13, 10, "		INVALID SELECTION! PLEASE CHOOSE A VALID OPTION (1-2). $", 0
    MSGQUANTITY_WARNING     DB        13, 10, "		MAXIMUM ALLOWED QUANTITY IS 1-9 $", 0
    msg_order               db        0dh, 0ah, "	What do you want to order: $"
    ask_add                 db        0dh, 0ah, "         Do you want to order more? (Y = YES | R = REMOVE | N = NO): $"
    ask_remove              db        0dh, 0ah, "		Do you want to remove items? "
                            db        0dh, 0ah,	"		1. Chicken tender"
                            db        0dh, 0ah, "		2. Steamed Rice"
                            db        0dh, 0ah,	"		3. French Fries"
                            db        0dh, 0ah,	"		4. Exit"
                            db        0dh, 0ah,	"		  -->$", 0
    msg_remove              db        0dh, 0ah, "		What do you want to remove: $"
    add_success             db        0dh, 0ah, "		Item added on successfully!!! $"
    success                 db        0dh, 0ah, "		Remove successfully!! $"
    failed                  db        0dh, 0ah, "		Remove failed!! $"
    newline                 db        0dh, 0ah, "$"
    FAMILY_BUCKET1          DB        0dh, 0ah, "	   Freshly Fried Chicken Tenders only for RM5! $",0
    MEAL_PLATE1             DB        0dh, 0ah, "	   Steamed Rice Perfect goes with your meal only for RM6! $",0
    ALA_CARTE1              DB        0dh, 0ah, "	   Crispy and soft french fries for only RM 4! $",0
    FAMILY_BUCKET1_PRICE    DW        5
    MEAL_PLATE1_PRICE       DW        6
    ALA_CARTE1_PRICE        DW        4
    MEAL_PLATE_RESULT       DB        0
    ALA_CARTE_RESULT        DB        0
    total_price             dw        0

    kendaki_price           dw        5                                                                                          ; Price for Kendaki
    mcd_price               dw        6                                                                                          ; Price for McD
    total_price_add         dw        0                                                                                          ; Total price initialized to 0
    greetings_add           db        0dh, 0ah,"	WELCOME TO ADD ON SECTION $", 0
    TOTAL_DISPLAY_ALL_PRICE DB        10,13, "		|======================================|"
                            DB        10,13, "		|  THE TOTAL PRICES FOR ALL FOOD IS    |"
                            DB        10,13, "		|                                      |"                                        ;this side show the food name
                            DB        10,13, "		|                                      |"                                        ;this side show the quantity
                            DB        10,13, "		|                                      |"                                        ;this side show the add on
                            DB        10,13, "		|                                      |"                                        ;this side show the quantity
    SHOW_ALL_PRICE          DB        10,13, "		The Total Price is RM $", 0
    final_msg               DB        10,13, "	 =============================================================="
                            DB        10,13, "	 <Thank you for your order! Your Amount for Add On and Meal is>"
                            DB        10,13, "	  ----> RM $", 0
    and_msg                 DB        " and RM $", 0
    SURE_EXIT               DB        10,13, "		Are you sure to exit? $", 0
    CONFIRMATION_EXIT       DB        10,13, "		Y(YES) || N(NO): $",0
	
	
    payM                    db        13,10, "		 	   1.Cash"
                            db        13,10, "		 	   2.Credit card"
                            db        13,10, "		 	   3.Exit $", 0

    PAYSEL                  DB        13,10, "		 PLEASE TYPE (1-3) TO PROCEED PAYMENT: $", 0
    CASHp                   DB        13,10, "		 PLEASE GO TO THE NEARBY RETAIL STORE TO MAKE PAYMENT. $", 0

    CC                      DB        13,10, "		 PLEASE ADD A CREDIT CARD TO MAKE PAYMENT "
                            DB        13,10, "		 Enter your Credit Card Number: $",0
	
    SUC                     DB        13,10, "		 THE CARD IS VALID,TOTAL PAYMENT IS RM $",0
    FAIL                    DB        13,10,"		 YOUR CARD SEEM NOT WORKING !!!! $",0

    TELLMEWHY               DB        13,10, "		 ==========PLEASE PROCEED TO PAYMENTS========== $",0
    ERROR_MSG               DB        13,10, "		 >>>>>>>>>>>>> PLEASE SELECT 1 TO 3 ONLY !!!!! $",0
    CARD_NUMBER             DB        16 DUP (0)
    ;DELIVERY PART
    DISTANCE_PRICE          DW        2
    DELIVERY_MESSAGE        DB        13,10, "		WELCOME TO KETUCKY DELIVERY SERVICES! $",0
    DELIVERY_MESSAGE1       DB        13,10, "Please enter your distances from the nearby kentucky branches(KM) MAX 9KM: $",0
    DELIVERY_MSG1           DB        13,10, "		Delivery added successfully. $", 0
    DELIVERY_TOTAL_PRICE    DW        0
    DISPLAY_PRICE_TOTAL     DW        0
    TOTAL_WITH_DELIVERY     DW        0
    FINAL_TOTAL_MSG         DB        13,10, "		 Final Total Price For Delivery is RM $", 0
    FINAL_TOTAL_STR         DB        6 DUP (' ')                                                                                ; Buffer for final total price (4 digits + '$' + NULL)
    INVALID_FOOD_ORDER      DB        13,10, "		INVALID QUANTITY ONLY ACCEPT (1-9) $",0
    INVALID_INPUT_MSG       DB        13,10, "		invalid input! $", 0
    REALLY_EXIT             DB        13,10, "		ARE YOU SURE YOU WANNA EXIT TRANSACTION? Y(YES) N(NO) : $", 0
    INVALID_MSG_KM          DB        13,10, "		Only accept number for kilometers! $", 0
.CODE
MAIN PROC
                              MOV  AX, @DATA
                              MOV  DS, AX
                              MOV  AH, 06H
                              MOV  AL, 0
                              MOV  BH, 07H
                              MOV  CX, 0000H
                              MOV  DX, 184FH
                              INT  10H
                              MOV  AH, 02H
                              MOV  BH, 00H
                              MOV  DH, 05H
                              MOV  DL, 18H
                              INT  10H

    MAIN_MENU:                
    ; Display the main menu
                              MOV  AH, 09H                       ;10bits AX 16bits
                              LEA  DX, MENU_ONE                  ;DX == 16bits
                              INT  21H                           ;stop the repeat process
    ; Get user selection
                              MOV  AH, 01H                       ; Function to read a character from the keyboard
                              INT  21H
                              MOV  SEL, AL                       ; Store the input character in SEL
							  
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
    ; Check user selection
                              CMP  SEL, '1'
                              JE   REGISTER_USER
                              CMP  SEL, '2'
                              JE   LOGIN_USER
                              CMP  SEL, '3'
                              JMP  EXIT_PROGRAM

    ; Call second menu
                              MOV  AH, 09H
                              LEA  DX, SECOND_MENU
                              INT  21H

    ; get customer selection
                              MOV  AH, 01H
                              INT  21H
                              MOV  SEL, AH

    ; Invalid input or other actions, return to the main menu
                              JMP  MAIN_MENU

    REGISTER_USER:            
    ; Call the REGISTER procedure
                              CALL REGISTER
    ; Return to the main menu after registration
                              JMP  MAIN_MENU

    LOGIN_USER:               
    ; Call the LOGIN procedure
                              CALL LOGIN
    ; Return to the main menu after login
                              JMP  MAIN_MENU
    EXIT_PROGRAM:             
    ; Exit program
                              MOV  AH,09H
                              LEA  DX, SURE_EXIT
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, CONFIRMATION_EXIT
                              INT  21H
                              MOV  AH, 01H
                              INT  21H
                              CMP  AL, 'n'
                              JE   MAIN_MENU
                              CMP  AL, 'y'
                              MOV  AX, 4C00H
                              INT  21H
MAIN ENDP
REGISTER PROC
    ; Input register NAME
                              MOV  AH, 09H
                              LEA  DX, MSGRN
                              INT  21H
                              MOV  AH, 0AH
                              LEA  DX, PARA_LIST
                              INT  21H
    ; Copy input data to REGNAME
                              MOV  CL, ACT_LEN
                              MOV  SI, 0
                              MOV  DI, OFFSET REGNAME
    LOADNAME:                 
                              MOV  AL, INPUT_DATA[SI]
                              MOV  [DI], AL
                              INC  SI
                              INC  DI
                              LOOP LOADNAME
    ; Input PASSWORD
                              MOV  AH, 09H
                              LEA  DX, MSGRP
                              INT  21H
                              MOV  AH, 0AH
                              LEA  DX, PARA_LIST
                              INT  21H
    
    ; Copy input data to REGPASSWORD
                              MOV  CL, ACT_LEN
                              MOV  SI, 0
                              MOV  DI, OFFSET REGPASSWORD
    LOADPASSWORD:             
                              MOV  AL, INPUT_DATA[SI]
                              MOV  [DI], AL
                              INC  SI
                              INC  DI
                              LOOP LOADPASSWORD

    ; Confirm PASSWORD
                              MOV  AH, 09H
                              LEA  DX, MSGCP
                              INT  21H
                              MOV  AH, 0AH
                              LEA  DX, PARA_LIST
                              INT  21H
    
    ; Copy input data to CONFIRMPASSWORD
                              MOV  CL, ACT_LEN
                              MOV  SI, 0
                              MOV  DI, OFFSET CONFIRMPASSWORD
    LOADCONFIRMPASSWORD:      
                              MOV  AL, INPUT_DATA[SI]
                              MOV  [DI], AL
                              INC  SI
                              INC  DI
                              LOOP LOADCONFIRMPASSWORD

    ; Compare PASSWORD and CONFIRMPASSWORD
                              MOV  SI, OFFSET REGPASSWORD
                              MOV  DI, OFFSET CONFIRMPASSWORD
                              MOV  CX, 8
    COMPAREPASSWORDS:         
                              MOV  AL, [SI]
                              MOV  BL, [DI]
                              CMP  AL, BL
                              JNE  PASSWORD_MISMATCH
                              INC  SI
                              INC  DI
                              LOOP COMPAREPASSWORDS

    ; If passwords match, registration successful
                              MOV  AH, 09H
                              LEA  DX, REGSUCCESS
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
							  
                              RET

    PASSWORD_MISMATCH:        
                              MOV  AH, 09H
                              LEA  DX, ERROR_CONFIRM
                              INT  21H
                              RET
REGISTER ENDP
LOGIN PROC
                              MOV  AH, 09H
                              LEA  DX, MSGLN
                              INT  21H
                              MOV  AH, 0AH
                              LEA  DX, PARA_LIST
                              INT  21H
    ; Copy input data to LOGINNAME
                              MOV  CL, ACT_LEN
                              MOV  SI, 0
                              MOV  DI, OFFSET LOGINNAME
    LOADLOGINNAME:            
                              MOV  AL, INPUT_DATA[SI]
                              MOV  [DI], AL
                              INC  SI
                              INC  DI
                              LOOP LOADLOGINNAME
    ; Input PASSWORD
                              MOV  AH, 09H
                              LEA  DX, MSGLP
                              INT  21H
                              MOV  AH, 0AH
                              LEA  DX, PARA_LIST
                              INT  21H
    ; Copy input data to LOGINPASSWORD
                              MOV  CL, ACT_LEN
                              MOV  SI, 0
                              MOV  DI, OFFSET LOGINPASSWORD
    LOADLOGINPASSWORD:        
                              MOV  AL, INPUT_DATA[SI]
                              MOV  [DI], AL
                              INC  SI
                              INC  DI
                              LOOP LOADLOGINPASSWORD
    ; Compare LOGINNAME and REGNAME
                              MOV  SI, OFFSET LOGINNAME
                              MOV  DI, OFFSET REGNAME
                              MOV  CX, 8
    COMPARENAMES:             
                              MOV  AL, [SI]
                              MOV  BL, [DI]
                              CMP  AL, BL
                              JNE  LOGIN_ERROR
                              INC  SI
                              INC  DI
                              LOOP COMPARENAMES
    ; Compare LOGINPASSWORD and REGPASSWORD
                              MOV  SI, OFFSET LOGINPASSWORD
                              MOV  DI, OFFSET REGPASSWORD
                              MOV  CX, 8
    COMPAREPASSWORDS2:        
                              MOV  AL, [SI]
                              MOV  BL, [DI]
                              CMP  AL, BL
                              JNE  LOGIN_ERROR
                              INC  SI
                              INC  DI
                              LOOP COMPAREPASSWORDS2
    ; If login successful
                              MOV  AH, 09H
                              LEA  DX, VMSG
                              INT  21H
    ; After successful login, go to second menu
                              JMP  FIRST_MENU_SELECTION
                              RET
    LOGIN_ERROR:              
    ; If login fails, show error message
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, IMSG
                              INT  21H
                         
                              INC  LOGIN_COUNT
                              CMP  LOGIN_COUNT, 3
                              JGE  LOGIN_FAIL
                         
                              RET
    LOGIN_FAIL:               
    ; If login attempts exceed limit, exit program
                              MOV  AH, 09H
                              LEA  DX, ERROR_FAIL
                              INT  21H
                              MOV  AX, 4C00H
                              INT  21H
                              RET
LOGIN ENDP
FIRST_MENU_SELECTION PROC
    GET_SELECTION:            
    ; Display the first menu
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, FIRST_MENU
                              INT  21H
    ; Get user input
                              MOV  AH, 01H                       ; Read character input
                              INT  21H
                              MOV  SEL, AL                       ; Store the input character
        
    ; Validate user input
                              CMP  SEL, '1'
                              JE   PROCESS_SELECTION
                              CMP  SEL, '2'
                              JE   PROCESS_SELECTION1
        
    ; If input is invalid, display an error message
                              MOV  AH, 09H
                              LEA  DX, INVALID_SELECTION_MSG1
                              INT  21H
    ; Get input again
                              JMP  GET_SELECTION
    PROCESS_SELECTION:        
    ; Check user selection and branch accordingly
                              CMP  SEL, '1'
                              JMP  SECOND_MENU_SELECTION
    PROCESS_SELECTION1:       
                              CMP  SEL, '2'
                              JMP  SECOND_MENU_SELECTION1

    ; In case of any other value, loop back to get valid input
                              JMP  GET_SELECTION
FIRST_MENU_SELECTION ENDP
    ;CHRISTOPHER PART
SECOND_MENU_SELECTION1 PROC
    ; Display delivery messages
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, DELIVERY_MESSAGE
                              INT  21H
                              
                              MOV  AH, 09H
                              LEA  DX, DELIVERY_MESSAGE1
                              INT  21H

    VALIDATE_DISTANCE_INPUT:  
    ; Get user input for distance
                              MOV  AH, 01H                       ; Wait for input
                              INT  21H                           ; Get input character

    ; Validate input (check if it's a number between '0' and '9')
                              CMP  AL, '0'                       ; Compare with '0'
                              JL   INVALID_INPUT3                ; If less than '0', invalid input
                              CMP  AL, '9'                       ; Compare with '9'
                              JG   INVALID_INPUT3                ; If greater than '9', invalid input

    ; Convert ASCII to integer
                              MOV  AH, 0H
                              SUB  AL, 30H                       ; Convert ASCII to number
                              MOV  QUANTITY1, AX                 ; Store the quantity (distance) in QUANTITY1

    ; Load the DISTANCE_PRICE
                              MOV  AX, DISTANCE_PRICE            ; Load DISTANCE_PRICE into AX
                              MUL  QUANTITY1                     ; Multiply AX by QUANTITY1 (result stored in DX:AX)

    ; Store the result in DELIVERY_TOTAL_PRICE
                              MOV  DELIVERY_TOTAL_PRICE, AX      ; Store the result in DELIVERY_TOTAL_PRICE

    ; Display confirmation message
                              MOV  AH, 09H
                              LEA  DX, DELIVERY_MSG1
                              INT  21H

    FIFNALIZE_DELIVERY_PRICE: 
    ; Display final total price
                              MOV  AX, DELIVERY_TOTAL_PRICE      ; Load the total price into AX
                              CALL CONVERT_TO_ASCII              ; Convert AX to ASCII string
                              MOV  AH, 09H
                              LEA  DX, FINAL_TOTAL_MSG
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, FINAL_TOTAL_STR
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
                              JMP  SECOND_MENU_SELECTION

                              RET

    INVALID_INPUT3:           
    ; Handle invalid input (non-numeric)
                              MOV  AH, 09H
                              LEA  DX, INVALID_MSG_KM            ; Display an error message for invalid input
                              INT  21H
                              JMP  VALIDATE_DISTANCE_INPUT       ; Loop back to ask for valid input again

SECOND_MENU_SELECTION1 ENDP
    ; Convert integer in AX to ASCII and store in FINAL_TOTAL_STR
CONVERT_TO_ASCII PROC
                              MOV  BX, 10                        ; Decimal base
                              MOV  CX, 0                         ; Clear CX (used to store number of digits)
                              MOV  SI, OFFSET FINAL_TOTAL_STR    ; Pointer to destination buffer

    CONVERT_LOOP1:            
                              XOR  DX, DX                        ; Clear DX before division
                              DIV  BX                            ; Divide AX by 10
                              ADD  DL, '0'                       ; Convert remainder to ASCII
                              MOV  [SI], DL                      ; Store ASCII character
                              INC  SI                            ; Move to next character
                              INC  CX                            ; Increment digit counter
                              TEST AX, AX                        ; Check if quotient is zero
                              JNZ  CONVERT_LOOP1                 ; Repeat if not zero

    ; Add NULL terminator
                              MOV  BYTE PTR [SI], '$'
                              RET
CONVERT_TO_ASCII ENDP
    ;CHARLS PART
SECOND_MENU_SELECTION PROC
    SECOND_MENU1:             
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, SECOND_MENU
                              INT  21H

    ; Get user selection from second menu
                              MOV  AH, 01H
                              INT  21H
                              MOV  SEL, AL

    ; Validate user input
                              CMP  SEL, '1'
                              JE   PROCESSS_SELECTION_SECOND
                              CMP  SEL, '2'
                              JE   PROCESSS_SELECTION_SECOND
                              CMP  SEL, '3'
                              JE   PROCESSS_SELECTION_SECOND
                              CMP  SEL, '4'
                              JMP  MAIN_MENU


    ; If input is invalid, display an error message
                              MOV  AH, 09H
                              LEA  DX, INVALID_SELECTION_MSG
                              INT  21H
    ; Get input again
                              JMP  SECOND_MENU1
    EXIT_PROGRAM2:            
                              MOV  AX, 4C00H
                              INT  21H
    PROCESSS_SELECTION_SECOND:
    ; Check user selection
                              CMP  SEL, '1'
                              JNE  CHECK_MEAL_PLATE
                              JMP  FAMILY_BUCKET_ORDER

    CHECK_MEAL_PLATE:         
                              CMP  SEL, '2'
                              JNE  CHECK_ALA_CARTE
                              JMP  MEAL_PLATE_ORDER

    CHECK_ALA_CARTE:          
                              CMP  SEL, '3'
                              JMP  ALA_CARTE_ORDER
    FAMILY_BUCKET_ORDER:      
    ; Display family bucket details
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, FAMILY_BUCKET
                              INT  21H
    VALIDATE_INPUT:           
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, MSGQUANTITY_WARNING
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, MSGQTY
                              INT  21H
                              MOV  AH, 01H
                              INT  21H
                              CMP  AL, '1'
                              JL   INVALID_INPUT
                              CMP  AL, '9'
                              JG   INVALID_INPUT

                              MOV  AH, 0H
                              SUB  AL, 30H                       ; Convert ASCII to number
                              MOV  QUANTITY, AX                  ; Store quantity
    ; Calculate total price in cents
                              MOV  AX, FAMILY_BUCKET_PRICE
                              MOV  BX, QUANTITY
                              MUL  BX                            ; Multiply price by quantity, store result in DX:AX
    ; Prepare for division by 100 to separate the ringgit and cents parts
                              MOV  CX, 100
                              DIV  CX                            ; AX = Total price in quotient , DX = remainder
                              MOV  TOTAL_PRICE_INT, AX
                              MOV  TOTAL_PRICE_FRAC, DX
                              MOV  AH, 09H
                              LEA  DX, MSGTOTAL
                              INT  21H
                              CALL DISPLAY_PRICE                 ; Display calculated price
                              JMP  ADD_ITEM

    INVALID_INPUT:            
    ; Display invalid quantity message (including non-numeric characters)
                              MOV  AH, 09H
                              LEA  DX, INVALID_FOOD_ORDER
                              INT  21H
                              JMP  VALIDATE_INPUT                ;Loop back to prompt again for valid input
    MEAL_PLATE_ORDER:         
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, MEAL_PLATE
                              INT  21H

    VALIDATE_INPUT2:          
                              MOV  AH, 09H
                              LEA  DX, MSGQUANTITY_WARNING
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, MSGQTY
                              INT  21H
                              MOV  AH, 01H
                              INT  21H
                              CMP  AL, '1'                       ; Check if input is '1'
                              JL   INVALID_INPUT                 ; If less than '1', it's invalid
                              CMP  AL, '9'                       ; Check if input is greater than '9'
                              JG   INVALID_INPUT                 ; If greater than '9', it's invalid

                              MOV  AH, 0H
                              SUB  AL, 30H                       ; Convert ASCII to number
                              MOV  QUANTITY, AX                  ; Store quantity
    ; Calculate total price in cents
                              MOV  AX, MEAL_PLATE_PRICE          ; Load price (1550 cents)
                              MOV  BX, QUANTITY                  ; Load quantity
                              MUL  BX                            ; Multiply price by quantity, result in DX:AX
    ; Prepare for division by 100 to separate the ringgit and cents parts
                              MOV  CX, 100                       ; Prepare to divide by 100 (100 cents in 1 ringgit)
                              DIV  CX                            ; AX = Total price in ringgit, DX = remainder
                              MOV  TOTAL_PRICE_INT, AX
                              MOV  TOTAL_PRICE_FRAC, DX
    ; Display total price
                              MOV  AH, 09H
                              LEA  DX, MSGTOTAL
                              INT  21H
                              CALL DISPLAY_PRICE                 ; Display calculated price
                              JMP  ADD_ITEM
    INVALID_INPUT2:           
    ; Display invalid quantity message (including non-numeric characters)
                              MOV  AH, 09H
                              LEA  DX, INVALID_FOOD_ORDER
                              INT  21H
                              JMP  VALIDATE_INPUT2               ; Loop back to prompt again for valid input
    ALA_CARTE_ORDER:          
    ; Display A La Carte details
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, ALA_CARTE
                              INT  21H
    
    VALIDATE_INPUT1:          
                              MOV  AH, 09H
                              LEA  DX, MSGQUANTITY_WARNING
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, MSGQTY
                              INT  21H
                              MOV  AH, 01H
                              INT  21H
                              CMP  AL, '1'                       ; Check if input is '1'
                              JL   INVALID_INPUT1                ; If less than '1', it's invalid
                              CMP  AL, '9'                       ; Check if input is greater than '9'
                              JG   INVALID_INPUT1                ; If greater than '9', it's invalid

                              MOV  AH, 0H
                              SUB  AL, 30H
                              MOV  QUANTITY, AX

    ; Calculate total price in cents
                              MOV  AX, ALA_CARTE_PRICE
                              MOV  BX, QUANTITY
                              MUL  BX                            ;AX:DX AX IS THE INT DX STORE REMAINDER OF THE PRICE
                          
    ; Prepare for division by 100 to separate the ringgit and cents parts
                              MOV  CX, 100                       ; Prepare to divide by 100 (100 cents in 1 ringgit)
                              DIV  CX                            ; AX = Total price in ringgit, DX = remainder (cents)


                              MOV  TOTAL_PRICE_INT, AX           ;FOR EXAMPLE 2 QUAN = 14.6 THIS STORE 14
                              MOV  TOTAL_PRICE_FRAC, DX          ; Store the fractional part THEN THIS STORE 60

    ; Display total price
                              MOV  AH, 09H
                              LEA  DX, MSGTOTAL
                              INT  21H

                              CALL DISPLAY_PRICE
                              JMP  ADD_ITEM

    INVALID_INPUT1:           
    ; Display invalid quantity message (including non-numeric characters)
                              MOV  AH, 09H
                              LEA  DX, INVALID_FOOD_ORDER
                              INT  21H
                              JMP  VALIDATE_INPUT1               ; Loop back to prompt again for valid input
SECOND_MENU_SELECTION ENDP
DISPLAY_PRICE PROC
    ; Display integer part of price (ringgit)
                              MOV  AX, TOTAL_PRICE_INT
                              CALL NUMBER_DISPLAY                ; This assumes NUMBER_DISPLAY can handle integer display

    ; Display decimal point
                              MOV  AH, 02H
                              MOV  DL, '.'
                              INT  21H

    ; Display fractional part (cents)
    ; We assume TOTAL_PRICE_FRAC contains the cents (0 to 99)
                              MOV  AX, TOTAL_PRICE_FRAC          ; Move the fractional part (cents) to AX
                              CMP  AX, 9                         ; Check if cents is less than 10
                              JG   DISPLAY_CENTS                 ; If greater than 9, display as two digits
                              MOV  AH, 02H                       ; If less than 10, display a leading zero
                              MOV  DL, '0'                       ; Display '0'
                              INT  21H

    DISPLAY_CENTS:            
                              CALL NUMBER_DISPLAY                ; Now display the fractional part (cents)

                              RET
DISPLAY_PRICE ENDP
NUMBER_DISPLAY PROC
                              PUSH AX                            ; Save AX on the stack

                              MOV  CX, 0                         ; Clear CX (digit count)
    ; Loop to extract digits
    CONVERT_LOOP:             
                              MOV  DX, 0                         ; Clear DX for division
                              MOV  BX, 10                        ; Divisor (for decimal conversion)
                              DIV  BX                            ; Divide AX by 10 (result in AX, remainder in DX)
                              PUSH DX                            ; Push remainder (digit) on the stack
                              INC  CX                            ; Increment digit count
                              CMP  AX, 0                         ; Check if there are more digits to process
                              JNE  CONVERT_LOOP                  ; Repeat until AX is 0
    ; Pop and display digits
    PRINT_DIGITS:             
                              POP  DX                            ; Pop the next digit from the stack
                              ADD  DL, '0'                       ; Convert   digit to ASCII
                              MOV  AH, 02H                       ; DOS function to display a character
                              INT  21H                           ; Display the digit
                              LOOP PRINT_DIGITS                  ; Repeat for all digits
 
                              POP  AX                            ; Restore AX from the stack
                              RET
NUMBER_DISPLAY ENDP
    ;JIAYAO PART
ADD_ITEM PROC
    ASK_ORDER_MORE:           
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, ask_add                   ; Ask if more items or removal is needed
                              INT  21H
                              MOV  AH, 01H
                              INT  21H
                              CMP  AL, 'r'
                              JE   ASK_REMOVE_ITEM
                              CMP  AL, 'y'
                              JE   SECOND_MENU_SELECTION_SEC
                              CMP  AL, 'n'
                              JE   OUTPUT_PRICE
                              JMP  ASK_ORDER_MORE                ; In case of an invalid response, repeat
    OUTPUT_PRICE:             
                              MOV  AH,09H
                              LEA  DX, final_msg
                              INT  21H
 
                              CALL DISPLAY_PRICE
                              JMP  PAYMENT_METHOD
    SECOND_MENU_SELECTION_SEC:
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, SECOND_MENU2              ; Show the second menu to the user
                              INT  21H
                              MOV  AH, 01H
                              INT  21H
                              CMP  AL, '1'                       ; 1 for FAMILY_BUCKET
                              JE   ADD_FAMILY_BUCKET_SEC
                              CMP  AL, '2'                       ; 2 for MEAL_PLATE
                              JE   ADD_MEAL_PLATE_SEC
    ALA_CARTE_PART:           
                              CMP  AL, '3'                       ; 3 for ALA_CARTE
                              JMP  ADD_ALA_CARTE_SEC
                              MOV  AH, 09H
                              LEA  DX, INVALID_INPUT_MSG         ; Display invalid input message
                              INT  21H
                              JMP  SECOND_MENU_SELECTION_SEC     ; Re-prompt for valid input
    ASK_REMOVE_ITEM:          
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, ask_remove
                              INT  21H
                              MOV  AH, 01H
                              INT  21H
                              CMP  AL, '1'                       ; 1 for FAMILY_BUCKET
                              JE   REMOVE_FAMILY_BUCKET
                              JMP  CANNOT_REMOVE
                              CMP  AL, '2'
                              JMP  CANNOT_REMOVE                 ; 2 for MEAL_PLATE
                              JE   REMOVE_MEAL_PLATE
                              CMP  AL, '3'
                              JMP  CANNOT_REMOVE                 ; 3 for ALA_CARTE
                              JE   REMOVE_ALA_CARTE
                              CMP  AL, '4'
                              JE   ASK_ORDER_MORE
                              JMP  CANNOT_REMOVE
    ADD_FAMILY_BUCKET_SEC:    
                              MOV  AH, 09H
                              LEA  DX, FAMILY_BUCKET1            ; Display Family Bucket details
                              INT  21H
                              CALL GET_QUANTITY                  ; Get the quantity entered
                              MOV  CX, AX                        ; Store the quantity in CX
                              MOV  AX, [FAMILY_BUCKET1_PRICE]
                              MUL  CX                            ; Calculate total price for this item
                              ADD  [TOTAL_PRICE_INT], AX         ; Add to total price
                              MOV  [FAMILY_RESULT], 1            ; Mark that Family Bucket was ordered
                              MOV  AH, 09H
                              LEA  DX, add_success
                              INT  21H
                              JMP  ASK_ORDER_MORE
    REMOVE_FAMILY_BUCKET:     
                              CMP  [FAMILY_RESULT], 0            ; Check if this item was ordered
                              CALL CANNOT_REMOVE                 ; If not ordered, cannot remove
                              DEC  [QUANTITY]
                              MOV  AX, [FAMILY_BUCKET1_PRICE]
                              SUB  [TOTAL_PRICE_INT], AX
                              JMP  REMOVE_SUCCESS
    ADD_MEAL_PLATE_SEC:       
                              MOV  AH, 09H
                              LEA  DX, MEAL_PLATE1               ; Display Meal Plate details
                              INT  21H
                              CALL GET_QUANTITY                  ; Get the quantity entered
                              MOV  CX, AX                        ; Store the quantity in CX
                              MOV  AX, [MEAL_PLATE1_PRICE]
                              MUL  CX                            ; Calculate total price for this item
                              ADD  [TOTAL_PRICE_INT], AX         ; Add to total price
                              MOV  [MEAL_PLATE_RESULT], 1        ; Mark that Meal Plate was ordered
                              MOV  AH, 09H
                              LEA  DX, add_success
                              INT  21H
                              JMP  ASK_ORDER_MORE
		
    REMOVE_MEAL_PLATE:        
                              CMP  [MEAL_PLATE_RESULT], 0        ; Check if this item was ordered
                              JE   CANNOT_REMOVE                 ; If not ordered, cannot remove
                              DEC  [QUANTITY]
                              MOV  AX, [MEAL_PLATE1_PRICE]
                              SUB  [TOTAL_PRICE_INT], AX
                              JMP  REMOVE_SUCCESS
			
    REMOVE_ALA_CARTE:         
                              CMP  [ALA_CARTE_RESULT], 0         ; Check if this item was ordered
                              JE   CANNOT_REMOVE                 ; If not ordered, cannot remove
                              DEC  [QUANTITY]
                              MOV  AX, [ALA_CARTE1_PRICE]
                              SUB  [TOTAL_PRICE_INT], AX
                              JMP  REMOVE_SUCCESS

                              CMP  AL, '3'                       ; 3 for ALA_CARTE
                              JE   ADD_ALA_CARTE_SEC
    ; Add A La Carte
    ADD_ALA_CARTE_SEC:        
                              MOV  AH, 09H
                              LEA  DX, ALA_CARTE1                ; Display A La Carte details
                              INT  21H
                              CALL GET_QUANTITY                  ; Get the quantity entered
                              MOV  CX, AX                        ; Store the quantity in CX
                              MOV  AX, [ALA_CARTE1_PRICE]
                              MUL  CX                            ; Calculate total price for this item
                              ADD  [TOTAL_PRICE_INT], AX         ; Add to total price
                              MOV  [ALA_CARTE_RESULT], 1         ; Mark that A La Carte was ordered
                              MOV  AH, 09H
                              LEA  DX, add_success
                              INT  21H
                              JMP  ASK_ORDER_MORE
    REMOVE_SUCCESS:           
                              MOV  AH, 09H
                              LEA  DX, success
                              INT  21H
                              MOV  AX, [total_price]             ; Load the updated total price
                              JMP  ASK_ORDER_MORE
                              JE   CANNOT_REMOVE                 ; If not ordered, cannot remove
		
    CANNOT_REMOVE:            
                              MOV  AH, 09H                       ; Display a message that item cannot be removed (price too low)
                              LEA  DX, newline
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, failed
                              INT  21H
                              JMP  ASK_ORDER_MORE
ADD_ITEM ENDP
GET_QUANTITY PROC
                              MOV  AH, 09H
                              LEA  DX, MSGQTY
                              INT  21H
                              MOV  AH, 01H
                              INT  21H
                              MOV  AH, 0H
                              SUB  AL, 30H                       ; Convert ASCII to number
                              MOV  AL, AL                        ; Store quantity
                              RET
GET_QUANTITY ENDP
DISPLAY_NUM PROC
    ; Subroutine to display a number stored in AX (word)
    ; Handle single and double-digit numbers
                              CMP  AX, 10
                              JL   SINGLE_DIGIT                  ; If AX < 10, handle as a single-digit number
                              
    ; Two-digit number
                              XOR  DX, DX                        ; Clear DX before division
                              MOV  BX, 10                        ; Divider for base 10
                              DIV  BX                            ; Divide AX by 10 (AX = quotient, DX = remainder)

    ; Convert quotient (tens place) to ASCII
                              ADD  AL, 30H                       ; Convert quotient to ASCII
                              MOV  DL, AL
                              MOV  AH, 02H
                              INT  21H                           ; Print quotient

    ; Convert remainder (units place) to ASCII
                              MOV  DL, DH                        ; DH contains the remainder
                              ADD  DL, 30H                       ; Convert remainder to ASCII
                              MOV  AH, 02H
                              INT  21H                           ; Print remainder

                              JMP  END_DISPLAY

    SINGLE_DIGIT:             
                              ADD  AL, 30H                       ; Convert single-digit number to ASCII
                              MOV  DL, AL
                              MOV  AH, 02H
                              INT  21H                           ; Print single digit

    END_DISPLAY:              
    ; Display newline after printing the number
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
                              RET
DISPLAY_NUM ENDP
    ;ARTHUR PART
PAYMENT_METHOD proc
                              MOV  AH, 09H
                              LEA  DX,newline
                              int  21h
                              MOV  AH, 09H
                              LEA  DX,newline
                              int  21h

                              mov  ah,09H
                              lea  dx, TELLMEWHY
                              int  21h

                              mov  ah,09H
                              lea  dx, payM
                              int  21h

                              MOV  AH, 09H
                              LEA  DX,newline
                              int  21h

                              mov  ah, 09H
                              lea  dx, PAYSEL
                              INT  21h
                              mov  ah, 01H
                              int  21h

                              CMP  AL, '1'
                              JE   CASHPAYMENT
                              CMP  AL, '2'
                              JE   CREDITC
                              CMP  AL, '3'
                              JNE  WRONGTYPO
							  
                              MOV  AH, 09H
                              LEA  DX, REALLY_EXIT
                              INT  21H
                              MOV  AH, 01H
                              INT  21H
                              MOV  SEL, AL

    LEAVE_TRANSACTION:        
                              CMP  SEL, 'y'
                              JE   EXIT_PROGRAM1
    STAY_TRANSACTION:         
                              CMP  SEL, 'n'
                              JE   PAYMENT_METHOD

                              JMP  WRONGTYPO
    CASHPAYMENT:              
                              MOV  AH, 09H
                              LEA  DX, CASHp
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX,newline
                              int  21h
                              jmp  MAIN_MENU
	
    EXIT_PROGRAM1:            
                              MOV  AX,4C00H
                              INT  21H

    WRONGTYPO:                
                              MOV  AH, 09H
                              LEA  DX,newline
                              int  21h
                              MOV  AH, 09H
                              LEA  DX,newline
                              int  21h
                              MOV  AH,09H
                              LEA  DX,ERROR_MSG
                              INT  21H
                              JMP  PAYMENT_METHOD

    CREDITC:                  
                              MOV  AH, 09H
                              LEA  DX, newline
                              INT  21H
                              MOV  AH, 09H
                              LEA  DX, CC
                              INT  21H

                              MOV  CX, 16
                              MOV  SI, 0
		
    userenter:                
                              MOV  AH,01H
                              INT  21H
                              CMP  AL, 13                        ;13 in ascii mean enter,use to check when i enter anything until i press ENTER only will show output
                              JE   CHECK_LENGTH
                              CMP  AL, '0'
                              JB   INVALID_CARD
                              CMP  AL, '9'
                              JA   INVALID_CARD
                              MOV  CARD_NUMBER[SI],AL
                              INC  SI
                              CMP  SI, 16
                              JGE  CHECK_LENGTH
                              LOOP userenter

    VALIDATE_CARD:            
                              JMP  CARD_VALID
	
    CHECK_LENGTH:             
                              CMP  SI,16
                              JE   VALIDATE_CARD
                              JMP  INVALID_CARD

    INVALID_CARD:             
                              MOV  AH, 09H
                              LEA  DX, FAIL
                              INT  21H
                              JMP  PAYMENT_METHOD

    CARD_VALID:               
                              MOV  AH, 09H
                              LEA  DX, SUC
                              INT  21H
                              CALL DISPLAY_PRICE
                              CALL FIFNALIZE_DELIVERY_PRICE
                              JMP  MAIN_MENU
PAYMENT_METHOD ENDP
END MAIN