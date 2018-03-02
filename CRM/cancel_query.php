<html>
<body>

<?php 
	$MeetID = $_POST["MeetID"];

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

	// cancel meeting
	$sql = "DELETE FROM meeting WHERE MeetID = '$MeetID'";

	if ($conn->query($sql) === TRUE) {
	    echo "Meeting record deleted successfully<br>";
	} else {
	    echo "Error: " . $sql . "<br>" . $conn->error;
	}

	$conn->close();
?>
<form action="cancel.php">
    <input type="submit" value="Go back" />
</form>
</body>
<html>