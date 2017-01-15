<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Content-Type: application/json');

include('classSimpleImage.php');

if (isset($_GET['url'])) {
	$link = $_GET['url'];

	if( $imageURL = file_get_contents( $link ) ) {

		if( $info = getimagesize( $link ) ) {
	        # Допустимые расширения
			$enabled = array( 'png', 'gif', 'jpeg' );

			# Вычисляем тип изображения
			$type = trim( strrchr( $info['mime'], '/' ), '/' );
			# Если тип не подходит
			if( !in_array( $type, $enabled ) ) die( $type . ' - Недопустимый тип файла' );
		}	
			
		$imagename = md5( time() . rand() ) . '.' . $type;
			
		$pathFileSave = 'old/' . $imagename;
		copy($link,$pathFileSave);


		$image = new SimpleImage();
		$image->load($pathFileSave);
		$image->resizeToWidth(530);
		
		if ($type = "gif") {
			$imagename = $imagename . '.jpg';
		}
		$image->save('new/' . $imagename);
		$resizeImageURL = 'http://'. $_SERVER["SERVER_NAME"] . '/resize/new/' . $imagename;
		echo json_encode(array("resizeImageURL"=>$resizeImageURL));		
	} else 
		die('Фатальная ошибка: файл по адресу <b>' . $link . '</b> не существует!');
}
?>
