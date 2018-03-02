<html>
<body>

<?php

$name = $_POST["BookedBy"];
$room = $_POST["Room"];
$participants = $_POST['participants'];
$partners = $_POST['partners'];
$timeStart = new DateTime($_POST["timeStart"]);
$timeEnd = new DateTime($_POST["timeEnd"]);
$timeStartStr = $_POST["timeStart"];
$timeEndStr = $_POST["timeEnd"];

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "CRM";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

echo "booking as follows: ";
echo "<br>by employee id: ".$name;
echo "<br>room: ".$room;
echo "<br>start time: ".$_POST["timeStart"];
echo "<br>end time: ".$_POST["timeEnd"];
echo "<br>participants: <br>";
foreach($participants as $value){
	echo "$value <br>";
}

// get the auto-incremented meeting ID
$sql = "SELECT MAX(MeetID) FROM Meeting";
$result = $conn->query($sql);
$row = $result->fetch_array(MYSQLI_BOTH);
$MeetID = (int)($row[0]+1);
echo "MeetID : ".$MeetID."<br>";

// get time duration
$sql = "SELECT TIMESTAMPDIFF(MINUTE, '$timeStartStr', '$timeEndStr')";
$result = $conn->query($sql);
$row = $result->fetch_array(MYSQLI_BOTH);
$Duration = $row[0]/60;
echo "Duration : ".$Duration."<br>";

// calculate cost
$sql = "SELECT hourly_price FROM Rooms WHERE name = '$room'";
$result = $conn->query($sql);
$row = $result->fetch_array(MYSQLI_BOTH);
$Cost = $row[0] * $Duration;
echo "Cost : ".$Cost."<br>";

$sql = "SELECT GroupID FROM Teams WHERE Employees_PersID = '$name'";
$result = $conn->query($sql);
$row = $result->fetch_array(MYSQLI_BOTH);
$GroupID = $row[0];
echo "GroupID : ".$GroupID."<br>";

// TODO: form requirements, make booking happen in page before, display success/fail message.
// CHECK TO SEE IF TEAM STILL ACTIVE, AND NO TIME OVERLAP

// get a list of meetings @ the booking room, traverse through each timestart & timeend x, see if
// x.timestart < this.timeStart || this.timeEnd < x. timeEnd. if So, return error.
$sql = "SELECT timeStart, timeENd FROM meeting WHERE Rooms_name = '$room'";
$result = $conn->query($sql);

// check time conflicts
if($timeEnd < $timeStart){
	echo "End time must be after start time!<br>";
	die();
}

while($row = $result->fetch_assoc()) {
	$tStart = new DateTime($row["timeStart"]);
	$tEnd = new DateTime($row["timeENd"]);
    if(($tStart <= $timeStart && $timeStart <= $tEnd)
     || ($tStart <= $timeEnd && $timeEnd <= $tEnd))
	{
		echo "Time conflict error!<br>";
		die();
	}

}

// INSERTION-----------------------------------------------------

// insert meeting
$sql = "INSERT INTO Meeting (MeetID, Rooms_name, BookedBy, Team, timeStart, timeENd, Duration, Cost)
VALUES ($MeetID, '$room', $name, $GroupID, '$timeStartStr', '$timeEndStr', $Duration, $Cost )";

if ($conn->query($sql) === TRUE) {
    echo "Meeting record inserted successfully<br>";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

// insert participants
foreach($participants as $value){
	$sql = "INSERT INTO Participants_int (Meeting, Employees_PersID)
	VALUES ('$MeetID', '$value')";
	if ($conn->query($sql) === TRUE) {
	    echo "Participant record inserted successfully<br>";
	} else {
	    echo "Error: " . $sql . "<br>" . $conn->error;
	}
}

foreach($partners as $value){
	$sql = "INSERT INTO Participants_ext (Meeting, Partners_PartnerID)
	VALUES ('$MeetID', '$value')";
	if ($conn->query($sql) === TRUE) {
	    echo "Participating partner record inserted successfully<br>";
	} else {
	    echo "Error: " . $sql . "<br>" . $conn->error;
	}
}




$conn->close();
?>

<form action="book.php">
    <input type="submit" value="Go back" />
</form>

</body>
<html>