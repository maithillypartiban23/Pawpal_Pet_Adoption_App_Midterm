<?php
Header("Access-Control-Allow-Origin: *");
include("dbconnect.php");

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    http_response_code(405);
    echo json_encode(array("status" => "failed", "message" => "Method Not Allowed"));
    exit();
}

if (
    !isset($_POST["user_id"]) || !isset($_POST["pet_name"]) || !isset($_POST["pet_type"]) || 
    !isset($_POST["category"]) || !isset($_POST["lat"]) || !isset($_POST["lng"]) || 
    !isset($_POST["description"]) || !isset($_POST["images"])
) {
    http_response_code(400);
    echo json_encode(array("status" => "failed", "message" => "Bad Request - Missing parameters"));
    exit();
}

$userid = $_POST["user_id"];
$pet_name = addslashes($_POST["pet_name"]);
$pet_type = $_POST["pet_type"];
$category = $_POST["category"];
$lat = $_POST["lat"];
$lng = $_POST["lng"];
$description = addslashes($_POST["description"]);
$images = $_POST["images"];

$ArrayImg = json_decode($images, true);
$imagePaths = [];

// Insert new pet into database
$sqlinsertpet = "INSERT INTO `tbl_pets`(`user_id`, `pet_name`, `pet_type`, `category`, `description`, `image_paths`, `lat`, `lng`)
 VALUES ('$userid','$pet_name','$pet_type','$category','$description','','$lat','$lng')";
 
try {
    if ($conn->query($sqlinsertpet) === TRUE) {
        $last_id = $conn->insert_id;
        
        for ($i = 0; $i < count($ArrayImg); $i++) {
            $imagebase64 = $ArrayImg[$i];         
            $decodedImage = base64_decode($imagebase64);  

            $filename = "../assets/pets/pet_" . $last_id . "_$i.png";  
            file_put_contents($filename, $decodedImage);
            $imagePaths[] = "assets/pets/pet_" . $last_id . "_$i.png";                          
        }

        $imagePathsJson = json_encode($imagePaths);
        $sqlUpdate = "UPDATE tbl_pets SET image_paths='$imagePathsJson' WHERE pet_id='$last_id'";
        $conn->query($sqlUpdate);

        $response = array('status' => 'success', 'message' => 'Pet submitted successfully');
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'message' => 'Pet not added: ' . $conn->error);
        sendJsonResponse($response);
    }
} catch (Exception $e) {
    $response = array('status' => 'failed', 'message' => $e->getMessage());
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>