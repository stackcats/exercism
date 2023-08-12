module GradeSchool exposing (Grade, Result(..), School, Student, addStudent, allStudents, emptySchool, studentsInGrade)


type alias Grade =
    Int


type alias Student =
    String


type alias School =
    List ( Grade, Student )


type Result
    = Added
    | Duplicate


emptySchool : School
emptySchool =
    []


cmp : ( Grade, Student ) -> ( Grade, Student ) -> Order
cmp ( g1, s1 ) ( g2, s2 ) =
    if g1 == g2 then
        compare s1 s2

    else
        compare g1 g2


addStudent : Grade -> Student -> School -> ( Result, School )
addStudent grade student school =
    if allStudents school |> List.member student then
        ( Duplicate, school )

    else
        ( Added, ( grade, student ) :: school |> List.sortWith cmp )


studentsInGrade : Grade -> School -> List Student
studentsInGrade grade =
    List.filter (Tuple.first >> (==) grade) >> List.map Tuple.second


allStudents : School -> List Student
allStudents =
    List.map Tuple.second
