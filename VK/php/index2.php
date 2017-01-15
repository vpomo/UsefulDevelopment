# Функция для загрузки и ресайза изображений
    function LoadAndResize( $url, $preview_path, $original_path, $size )
    {
        /*
         * $url - ссылка на изображение
         * $preview_path - папка, куда сохраняем превьюшки
         * $original_path - папка, куда сохраняем оригинал
         * $size - размер большей строны (в пикселях)
        */
        
        # Допустимые расширения
        $enabled = array( 'png', 'gif', 'jpeg' );
        
        # Получаем изображение. Если функция не отработала
        if( $image = file_get_contents( $url ) )
        {
            # Генерируем имя tmp-изображения
            $tmp_name = 'tmp' . DIRECTORY_SEPARATOR . time();
            
            # Сохраняем изображение            
            file_put_contents( $tmp_name, $image );
            
            # Очищаем память
            unset( $image );
            
            # Если getimagesize вернула массив
            if( $info = getimagesize( $tmp_name ) )
            {
                # Вычисляем тип изображения
                $type = trim( strrchr( $info['mime'], '/' ), '/' );
                
                # Если тип не подходит
                if( !in_array( $type, $enabled ) ) die( $type . ' - Недопустимый тип файла' );
                
                # Исходя из типа формируем названия функций
                $imagecreate = 'imagecreatefrom' . $type;
                $imagesave = 'image' . $type;
                $imagename = md5( time() . rand() ) . '.' . $type;
 
                # Получаем данные об изображении
                list( $width, $height ) = $info;
                
                # Создаём ресурс изображения
                $src_im = $imagecreate( $tmp_name );
                
                # Вычисляем ширину
                $new_width = $width > $height ? $size : ceil( ( $width * $size ) / $height );
                
                # Вычисляем высоту
                $new_height = $width < $height ? $size : ceil( ( $height * $size ) / $width );
 
                # Создаём новое изображение
                $dst_im = imagecreatetruecolor( $new_width, $new_height );
                
                # Ресайзим
                imagecopyresampled( $dst_im, $src_im, 0, 0, 0, 0, $new_width, $new_height, $width, $height );
                
                # Чистим память
                unset( $src_im );
                
                # Сохраняем оригинал
                if( !copy( $tmp_name, $original_path . $imagename ) ) $return = false;                
                
                # Сохраняем превьюшку
                if( !$imagesave( $dst_im, $preview_path . $imagename ) ) $return = false;
                
                # Очищаем память
                unset( $dst_im );
                unlink( $tmp_name );
                
                # Возвращаем
                return !$return ? : true;
            }
            else
                die('Фатальная ошибка: файл по адресу <b>' . $url . '</b> не является изображением!');
        }
    }

Она прокомментирована - поймёте что к чему. В той же дире