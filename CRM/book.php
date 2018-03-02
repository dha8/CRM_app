<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>CRM - Book a Meeting</title>
  <!-- Bootstrap core CSS-->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom fonts for this template-->
  <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">
  <!-- Custom DateTimePicker-->
  <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
  <script type="text/javascript" src="js/jquery-3.3.1.min.js" charset="UTF-8"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-datetimepicker.js" charset="UTF-8"></script>

</head>

<body class="fixed-nav sticky-footer bg-dark" id="page-top">
  <!-- Navigation-->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <a class="navbar-brand" href="index.php">CRM Admin</a>
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
        <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Meeting Schedule">
          <a class="nav-link" href="index.php">
            <i class="fa fa-fw fa-calendar"></i>
            <span class="nav-link-text">Meeting Schedule</span>
          </a>
        </li>
        <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Tables">
          <a class="nav-link" href="book.php">
            <i class="fa fa-fw fa-calendar-plus-o"></i>
            <span class="nav-link-text">Book a Meeting</span>
          </a>
        </li>
    <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Tables">
          <a class="nav-link" href="cancel.php">
            <i class="fa fa-fw fa-calendar-times-o"></i>
            <span class="nav-link-text">Cancel a Meeting</span>
          </a>
        </li>
      </ul>
    </div>
  </nav>
  <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.php">Dashboard</a>
        </li>
        <li class="breadcrumb-item active">Book a Meeting</li>
      </ol>
      <div class="row">
        <div class="col-12">
          <h1>Book a Meeting</h1>
          <form action="book_query.php" method="post">
            <?php        
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
              // Booked_by employee ID
              $sql = "SELECT * FROM employees";
              $result = $conn->query($sql);
              echo 'Booking Employee ID: ';
              echo '<select name="BookedBy">';
              while($row = $result->fetch_assoc()) {
                echo '<option value='.$row["PersID"].'>'.$row["PersID"].'</option><br>';
              }
              echo '</select><br>';

              // rooms
              $sql = "SELECT * FROM  Rooms";
              $result = $conn->query($sql);
              echo 'Room Name: ';
              echo '<select name="Room">';
              while($row = $result->fetch_assoc()) {
                echo '
                    <option value="'.$row["name"].'">'.$row["name"].' - '.$row["hourly_price"].'/hr</option>
                ';          
              }
              echo '</select><br>';

              // participants_internal
              $sql = "SELECT * FROM employees";
              $result = $conn->query($sql);
              echo 'Participants: ';
              echo 'Ctrl + click to select/deselect multiple.<br>';
              echo '<select name="participants[]" multiple>';
              while($row = $result->fetch_assoc()) {
                echo '
                    <option value="'.$row["PersID"].'">'.$row["PersID"].' - '.$row["Name"].' '.$row["Surname"].'</option><br>
                ';
              }
              echo '</select><br>';

              // participants_external
              $sql = "SELECT * FROM partners";
              $result = $conn->query($sql);
              echo 'Partners: ';
              echo 'Ctrl + click to select/deselect multiple.<br>';
              echo '<select name="partners[]" multiple>';
              while($row = $result->fetch_assoc()) {
                echo '
                    <option value="'.$row["PartnerID"].'">'.$row["PartnerID"].' - '.$row["Name"].'</option><br>
                ';
              }
              echo '</select>';

            ?>

            <br>
            <!-- time -->
            <br>
            Start Time:
              <input size="16" type="datetime" name="timeStart" readonly class="form_datetime">
              <script type="text/javascript">
                $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});
              </script>       
            <br>
            End Time:
              <input size="16" type="datetime" name="timeEnd" readonly class="form_datetime">
              <script type="text/javascript">
                $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});
              </script>       
            <br>
            <input type="submit">
          </form>

        </div>
      </div>
    </div>
    <!-- /.container-fluid-->
    <!-- /.content-wrapper-->
    <footer class="sticky-footer">
      <div class="container">
        <div class="text-center">
          <small>Copyright © dha8, wgrom 2018</small>
        </div>
      </div>
    </footer>
    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fa fa-angle-up"></i>
    </a>
    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin.min.js"></script>
  </div>
</body>

</html>
