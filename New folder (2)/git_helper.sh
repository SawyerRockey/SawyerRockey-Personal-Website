#!/bin/bash
# Guess the number game... and a shell scripter? okay.

#variables
cmd=""
file=""
ranNum=""
guessNum=""
rolledNum=""
regularExpressionTest='^[0-9]+$'
commitMsg=""

#literally just a print statement
help(){
    echo -e " sst - (Git Status) \n sad - (Git Add) \n sco - (Git Commit) \n sps - (Git Push) \n spl - (Git Pull) \n sgn - (Guess the Number Game) - exit (You can read)"
}

sst(){
    echo -e "\nYour status:"
    git status
    echo -e "-------------------- END OF STATUS --------------------\n"
}

#Git Add, tells you what files, and confirms if you added or not.
sad(){
    echo -e "\nFilename to add." 
    ls 
    echo -e "\nEnter "." to add all:"
    read file
    if [ $file != "." ]; then
        echo -e "\nAttempting to add $file!"
    else 
        echo -e "Adding ALL Files in " $PWD
    git add $file
    fi
}

#Guess the number game
sgn(){
    echo -e "Choose a number greater than 1... Then, you will guess a random number between 1 and the number you have chosen."
    while :
    do
        if [[ ! $ranNum =~ $regularExpressionTest ]] || (( ranNum < 1 )); then
            echo -e "\nEnter your maximum value (A number greater than 1):"
            read ranNum
        else
            break
        fi
    done
    echo -e "You chose: $ranNum\n"
    while :
    do
        if [[ ! $guessNum =~ $regularExpressionTest ]] || (( guessNum < 1 )) || (( guessNum > $ranNum )); then
            echo -e "Now, guess a value in the range of 1 - $ranNum:\n"
            read guessNum
        else
            break
        fi
    done
    
    echo -e "You guessed: $guessNum!\nGood luck..."
    echo -e "\n3\n"
    sleep 1
    echo -e "\n2\n"
    sleep 1
    echo -e "\n1...\n"
    sleep 1
    echo -e "\nYou rolled...\n"

    rolledNum=$[ ($RANDOM % $ranNum) + 1 ]
    echo -e "$rolledNum!!!\n"

    if [[ $rolledNum = $guessNum ]]; then
    echo -e "HOLY MOLY! You beat the odds and won!\n\nWOOOHOOOO!!!!\n\n"
    else
    echo -e "you lose bud.\n"
    fi
    ranNum=""
    guessNum=""
    rolledNum=""
}
#commity
sco(){
    echo -e "Enter commit message: "
    read commitMsg
    git commit -m "$commitMsg"
}
#push
sps(){
    echo -e "Attempting to push...\n"
    git push
}
#im getting lazier with the comments as i go on
spl(){
    echo -e "Attempting to pull...\n"
    git pull
}


#main, idk it does what main does reads the commands and starts when it starts
main(){
    echo -e "\nHello, please enter your command! \nType ShellHelp for a list of commands, or type exit.\n"
    echo -e "Enter your command: "

    while :
    do
        read cmd
        echo -e "\n"
        case $cmd in
            ShellHelp)
                help
                ;;
            sst)
                sst
                ;;
            sad)
                sad
                ;;
            sco)
                sco
                ;;
            sps)
                sps
                ;;
            spl)
                spl
                ;;
            sgn)
                sgn
                ;;
            exit|q)
                break
                ;;
            *)
                echo -e "Invalid command... \n"
                ;;
        esac
    done
    echo -e "\nGoodbye, friend!"
    exit 0;
}

main