#!/bin/sh

#Test file names
tmpDir="$(pwd)/tmpDir";
A="$tmpDir/A.txt";
B="$tmpDir/B.txt";
C="$tmpDir/C.txt";
D="$tmpDir/D.txt";
E="$tmpDir/E.txt";
F="$tmpDir/F.txt";
G="$tmpDir/G.txt";

#Matrix dimensions
AB="3 2 4";
BC="2 4 6";
CD="4 6 3";
DA="6 3 2";
DE="6 3 5";
EF="3 5 3";
FE="5 3 5";
GE="5 3 5"

#Results
ABAns="402";
BCAns="3060";
CDAns="9180";
DAAns="1245";
DEAns="7140";
EFAns="3150";
FEAns="5050";
GEAns="-5050";


function writeTestFiles {
    mkdir $tmpDir;

    echo -e "1 2\n 3 4\n 5 6" > $A;
    echo -e "1 2 3 4\n 5 6 7 8" > $B;
    echo -e "1 2 3 4 5 6\n7 8 9 10 11 12\n13 14 15 16 17 18\n19 20 21 22 23 24" > $C;
    echo -e "1 2 3\n4 5 6\n 7 8 9\n10 11 12\n13 14 15\n16 17 18" > $D;
    echo -e "1 2 3 4 5\n6 7 8 9 10\n11 12 13 14 15" > $E;
    echo -e "1 2 3\n4 5 6\n7 8 9\n10 11 12\n13 14 15" > $F;
    echo -e "-1 -2 -3\n-4 -5 -6\n-7 -8 -9\n-10 -11 -12\n-13 -14 -15" > $G;
}

function cleanupFiles {
    rm -rf $A $B $C $D $E $F $G $tmpDir;
}

# $1 = exec, $2 = m_A, $3 = m_B,
# $4 = m_AB_dimensions, $5 = Ans
function test () {
    echo "##########################";
    echo "####### Test $4 #######";
    echo "##########################";
    ./$1 $2 $3 $4;
    echo -e "expected: $5\n\n";
}

if [ $# == 1 ] ; then

    writeTestFiles;

    test $1 $A $B "$AB" $ABAns;
    test $1 $B $C "$BC" $BCAns;
    test $1 $C $D "$CD" $CDAns;
    test $1 $D $A "$DA" $DAAns;
    test $1 $D $E "$DE" $DEAns;
    test $1 $E $F "$EF" $EFAns;
    test $1 $F $E "$FE" $FEAns;
    test $1 $G $E "$GE" $GEAns;

    cleanupFiles;
fi