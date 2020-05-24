<?php

// 应用公共函数库文件

use think\Request;
use think\Log;
use think\Db;
/**
 * 打印调试函数
 * @param $content
 * @param $is_die
 */
function pre($content, $is_die = true)
{
    header('Content-type: text/html; charset=utf-8');
    echo '<pre>' . print_r($content, true);
    $is_die && die();
}

/**
 * 驼峰命名转下划线命名
 * @param $str
 * @return string
 */
function toUnderScore($str)
{
    $dstr = preg_replace_callback('/([A-Z]+)/', function ($matchs) {
        return '_' . strtolower($matchs[0]);
    }, $str);
    return trim(preg_replace('/_{2,}/', '_', $dstr), '_');
}

/**
 * 生成密码hash值
 * @param $password
 * @return string
 */
function yoshop_hash($password)
{
    return md5(md5($password) . 'yoshop_salt_SmTRx');
}

/**
 * 获取当前域名及根路径
 * @return string
 */
function base_url()
{
    static $baseUrl = '';
    if (empty($baseUrl)) {
        $request = Request::instance();
        $subDir = str_replace('\\', '/', dirname($request->server('PHP_SELF')));
        $baseUrl = $request->scheme() . '://' . $request->host() . $subDir . ($subDir === '/' ? '' : '/');
    }
    return $baseUrl;
}

/**
 * 写入日志 (废弃)
 * @param string|array $values
 * @param string $dir
 * @return bool|int
 */
function write_log($values, $dir)
{
    if (is_array($values))
        $values = print_r($values, true);
    // 日志内容
    $content = '[' . date('Y-m-d H:i:s') . ']' . PHP_EOL . $values . PHP_EOL . PHP_EOL;
    try {
        // 文件路径
        $filePath = $dir . '/logs/';
        // 路径不存在则创建
        !is_dir($filePath) && mkdir($filePath, 0755, true);
        // 写入文件
        return file_put_contents($filePath . date('Ymd') . '.log', $content, FILE_APPEND);
    } catch (\Exception $e) {
        return false;
    }
}

/**
 * 写入日志 (使用tp自带驱动记录到runtime目录中)
 * @param $value
 * @param string $type
 */
function log_write($value, $type = 'yoshop-info')
{
    $msg = is_string($value) ? $value : var_export($value, true);
    Log::record($msg, $type);
}

/**
 * curl请求指定url (get)
 * @param $url
 * @param array $data
 * @return mixed
 */
function curl($url, $data = [])
{
    // 处理get数据
    if (!empty($data)) {
        $url = $url . '?' . http_build_query($data);
    }
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_HEADER, false);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);//这个是重点。
    $result = curl_exec($curl);
    curl_close($curl);
    return $result;
}

/**
 * curl请求指定url (post)
 * @param $url
 * @param array $data
 * @return mixed
 */
function curlPost($url, $data = [])
{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    $result = curl_exec($ch);
    curl_close($ch);
    return $result;
}

if (!function_exists('array_column')) {
    /**
     * array_column 兼容低版本php
     * (PHP < 5.5.0)
     * @param $array
     * @param $columnKey
     * @param null $indexKey
     * @return array
     */
    function array_column($array, $columnKey, $indexKey = null)
    {
        $result = array();
        foreach ($array as $subArray) {
            if (is_null($indexKey) && array_key_exists($columnKey, $subArray)) {
                $result[] = is_object($subArray) ? $subArray->$columnKey : $subArray[$columnKey];
            } elseif (array_key_exists($indexKey, $subArray)) {
                if (is_null($columnKey)) {
                    $index = is_object($subArray) ? $subArray->$indexKey : $subArray[$indexKey];
                    $result[$index] = $subArray;
                } elseif (array_key_exists($columnKey, $subArray)) {
                    $index = is_object($subArray) ? $subArray->$indexKey : $subArray[$indexKey];
                    $result[$index] = is_object($subArray) ? $subArray->$columnKey : $subArray[$columnKey];
                }
            }
        }
        return $result;
    }
}

/**
 * 多维数组合并
 * @param $array1
 * @param $array2
 * @return array
 */
function array_merge_multiple($array1, $array2)
{
    $merge = $array1 + $array2;
    $data = [];
    foreach ($merge as $key => $val) {
        if (
            isset($array1[$key])
            && is_array($array1[$key])
            && isset($array2[$key])
            && is_array($array2[$key])
        ) {
            $data[$key] = array_merge_multiple($array1[$key], $array2[$key]);
        } else {
            $data[$key] = isset($array2[$key]) ? $array2[$key] : $array1[$key];
        }
    }
    return $data;
}

/**
 * 二维数组排序
 * @param $arr
 * @param $keys
 * @param bool $desc
 * @return mixed
 */
function array_sort($arr, $keys, $desc = false)
{
    $key_value = $new_array = array();
    foreach ($arr as $k => $v) {
        $key_value[$k] = $v[$keys];
    }
    if ($desc) {
        arsort($key_value);
    } else {
        asort($key_value);
    }
    reset($key_value);
    foreach ($key_value as $k => $v) {
        $new_array[$k] = $arr[$k];
    }
    return $new_array;
}

/**
 * 数据导出到excel(csv文件)
 * @param $fileName
 * @param array $tileArray
 * @param array $dataArray
 */
function export_excel($fileName, $tileArray = [], $dataArray = [])
{
    ini_set('memory_limit', '512M');
    ini_set('max_execution_time', 0);
    ob_end_clean();
    ob_start();
    header("Content-Type: text/csv");
    header("Content-Disposition:filename=" . $fileName);
    $fp = fopen('php://output', 'w');
    fwrite($fp, chr(0xEF) . chr(0xBB) . chr(0xBF));// 转码 防止乱码(比如微信昵称)
    fputcsv($fp, $tileArray);
    $index = 0;
    foreach ($dataArray as $item) {
        if ($index == 1000) {
            $index = 0;
            ob_flush();
            flush();
        }
        $index++;
        fputcsv($fp, $item);
    }
    ob_flush();
    flush();
    ob_end_clean();
}

/**
 * 隐藏敏感字符
 * @param $value
 * @return string
 */
function substr_cut($value)
{
    $strlen = mb_strlen($value, 'utf-8');
    if ($strlen <= 1) return $value;
    $firstStr = mb_substr($value, 0, 1, 'utf-8');
    $lastStr = mb_substr($value, -1, 1, 'utf-8');
    return $strlen == 2 ? $firstStr . str_repeat('*', $strlen - 1) : $firstStr . str_repeat("*", $strlen - 2) . $lastStr;
}

/**
 * 获取当前系统版本号
 * @return mixed|null
 * @throws Exception
 */
function get_version()
{
    static $version = null;
    if ($version) {
        return $version;
    }
    $file = dirname(ROOT_PATH) . '/version.json';
    if (!file_exists($file)) {
        throw new Exception('version.json not found');
    }
    $version = json_decode(file_get_contents($file), true);
    if (!is_array($version)) {
        throw new Exception('version cannot be decoded');
    }
    return $version['version'];
}

/**
 * 获取全局唯一标识符
 * @param bool $trim
 * @return string
 */
function getGuidV4($trim = true)
{
    // Windows
    if (function_exists('com_create_guid') === true) {
        $charid = com_create_guid();
        return $trim == true ? trim($charid, '{}') : $charid;
    }
    // OSX/Linux
    if (function_exists('openssl_random_pseudo_bytes') === true) {
        $data = openssl_random_pseudo_bytes(16);
        $data[6] = chr(ord($data[6]) & 0x0f | 0x40);    // set version to 0100
        $data[8] = chr(ord($data[8]) & 0x3f | 0x80);    // set bits 6-7 to 10
        return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4));
    }
    // Fallback (PHP 4.2+)
    mt_srand((double)microtime() * 10000);
    $charid = strtolower(md5(uniqid(rand(), true)));
    $hyphen = chr(45);                  // "-"
    $lbrace = $trim ? "" : chr(123);    // "{"
    $rbrace = $trim ? "" : chr(125);    // "}"
    $guidv4 = $lbrace .
        substr($charid, 0, 8) . $hyphen .
        substr($charid, 8, 4) . $hyphen .
        substr($charid, 12, 4) . $hyphen .
        substr($charid, 16, 4) . $hyphen .
        substr($charid, 20, 12) .
        $rbrace;
    return $guidv4;
}

/**
 * 时间戳转换日期
 * @param $timeStamp
 * @return false|string
 */
function format_time($timeStamp)
{
    return date('Y-m-d H:i:s', $timeStamp);
}

//多维数组转换成一维数组
function array_merge_rec(&$array) {  
    // 定义一个新的数组
    $new_array = array ();
    // 遍历当前数组的所有元素
    foreach ( $array as $item ) {
        if (is_array ( $item )) {
            // 如果当前数组元素还是数组的话，就递归调用方法进行合并
            array_merge_rec ( $item );
            // 将得到的一维数组和当前新数组合并
            $new_array = array_merge ( $new_array, $item );
        } else {
            // 如果当前元素不是数组，就添加元素到新数组中
            $new_array [] = $item;
        }
    }
    // 修改引用传递进来的数组参数值
    $array = $new_array;
}

//获取rank大于0的所有下线
function zhiwei_jinji_userids($array,$type=true) {  
    // 定义一个新的数组
     $new_array = array ();
    // 遍历当前数组的所有元素
    foreach ( $array as $key =>$value ) {
        
        if ($value["rank"]>0) { 
            $user_id=Db::table("vic_dealer_referee")->where("dealer_id",$value["user_id"])->field("user_id")->select()->toArray();
            $user_ids=array_column($user_id,"user_id");
            
            $user_id_1=Db::table("vic_user")->where("user_id","in",$user_ids)->where("is_delete",0)->field("user_id,rank")->select()->toArray();
            $user_ids=array_column($user_id_1,"user_id");
            //把自己加入到user_id列表 
            if ($type) {
                 array_push($user_ids,$value["user_id"]);
            }
           

            $new_array = array_merge ($new_array,$user_ids);
           
            zhiwei_jinji_userids ($user_id_1);
        } else {
            $user_id_2=Db::table("vic_user")->where("user_id",$value["user_id"])->where("is_delete",0)->field("user_id")->select()->toArray();
            $user_ids=array_column($user_id_2,"user_id");
            //$new_array [] = $user_id_1;
            $new_array = array_merge ($new_array,$user_ids);
        }
        
    }
    // 修改引用传递进来的数组参数值
    //$array = $new_array;
    return array_unique($new_array);
}

 /**
     * 根据条件修改职位名称
     */
    
    //代理商晋级销售主任
     function set_dailishang_rank()
    { 

        //代理商下面有>=20的user_id
       $sql="SELECT GROUP_CONCAT(a.user_id) user_id from vic_dealer_referee a JOIN vic_user b on a.user_id=b.user_id JOIN vic_dealer_user c on 
                c.user_id=a.dealer_id  where b.is_delete=0 and c.is_delete=0 GROUP BY a.dealer_id HAVING count(*) >=20";        
        $userid=Db::query($sql);
        if(count($userid)>0){
            //转换成数组
             foreach ($userid as $key => $value) {
                 $user_id[$key]["user_id"]=explode(",",$value["user_id"]);
             }
            //查找代理商
            foreach ($user_id as $key => $value) {
                static $daili_user_id=[];
                $daili_user_id=array_merge($daili_user_id,$value["user_id"]);
            }
            $daili[$key]=Db::table("vic_dealer_user")->where("user_id","in",$daili_user_id)->where("rank",1)->select()->toArray();
            //去掉空值
            $daili=array_filter($daili);
            if (count($daili)>0){
                //满足条件晋级主任
                foreach ($daili as $key => $values) {
                    if(count($values)>=20){//晋级条件  
                        //父级代理商ID
                        $dealer_id=Db::table("vic_dealer_referee")->field("dealer_id")->where("user_id",$values[0]["user_id"])->select();

                        //父级代理商自己消费金额(不包含退款)
                        $dealer_money=Db::table("vic_user")->where("user_id",$dealer_id[0]["dealer_id"])->field("expend_money")->select();
                        $dealer_money=floatval($dealer_money[0]["expend_money"]);

                        //获取父级代理商下面所有的下线，包含代理商
                        $fujixia_userid=Db::table("vic_dealer_referee")->field("user_id")->where("dealer_id",$dealer_id[0]["dealer_id"])->select()->toArray(); 
                        $fujixia_userids = array_column($fujixia_userid,"user_id");

                        //父级代理商下面代理商的下线
                        //foreach ($daili as $key => $value) {
                                foreach ($values as $k => $v) {
                                    $dd[$k]=Db::table("vic_dealer_referee")->field("user_id")->where("dealer_id",$v["user_id"])->select()->toArray();
                                }                      
                        //}
                        array_merge_rec($dd);//转换成一维数组

                        //父级代理商下所有下线 
                        $user_ids=array_merge($fujixia_userids,$dd);

                        $fujixia_money=Db::table("vic_user")->field("expend_money")->where("user_id","in",$user_ids)->where("is_delete",0)->select()->toArray();
                        //父级代理商下线总消费（包含代理商）   
                        foreach ($fujixia_money as $k => $v) {
                            //下线总消费
                            static $xiaxain_total_money=0;
                            $xiaxain_total_money+=floatval($v["expend_money"]);
                        }
  
                        //父级代理商与下线总消费
                        $zong_money=$dealer_money+$xiaxain_total_money;
                        if ($zong_money>=30000) {
                            Db::table("vic_dealer_user")->where("user_id",$dealer_id[0]["dealer_id"])->setField("rank",2);
                            Db::table("vic_user")->where("user_id",$dealer_id[0]["dealer_id"])->setField("rank",2);
                        }                        
                     }
                     //查找到代理商的vic_user的职位改写
                        foreach ($values as $key => $v) {
                            Db::table("vic_user")->where("user_id",$v["user_id"])->setField("rank",1);
                        }                  
                }
                
            }     
        }else{
            return false;
        }
        
    }

     //销售主任晋级销售经理
     function set_zhuren_rank()
    {  
         //销售主任下面有>=5的user_id
        $sql="SELECT GROUP_CONCAT(a.user_id) user_id from vic_dealer_referee a JOIN vic_user b on a.user_id=b.user_id JOIN vic_dealer_user c on 
                c.user_id=a.dealer_id  where b.is_delete=0 and c.is_delete=0 GROUP BY a.dealer_id HAVING count(*) >=5";        
        $userid=Db::query($sql);
        if(count($userid)>0){
            //转换成数组
             foreach ($userid as $key => $value) {
                 $user_id[$key]["user_id"]=explode(",",$value["user_id"]);
             }
            //查找销售主任
            foreach ($user_id as $key => $value) {
                static $daili_user_id=[];
                $daili_user_id=array_merge($daili_user_id,$value["user_id"]);
            }
            $zhuren[$key]=Db::table("vic_dealer_user")->where("user_id","in",$daili_user_id)->where("rank",2)->select()->toArray();
            //去掉空值
            $zhuren=array_filter($zhuren);
            if (count($zhuren)>0){
                //满足条件晋级经理
                foreach ($zhuren as $key => $values) {
                    if(count($values)>=5){//主任晋级销售经理  >=5
                        $dealer_id=Db::table("vic_dealer_referee")->field("dealer_id")->where("user_id",$values[0]["user_id"])->select();
                        //父级主任自己消费金额(不包含退款)
                        $dealer_money=Db::table("vic_user")->where("user_id",$dealer_id[0]["dealer_id"])->field("expend_money")->select();
                        $zhuren_money=floatval($dealer_money[0]["expend_money"]);

                        //主任直接下线用户
                        $zhurenxia_userid=Db::table("vic_dealer_referee")->where("dealer_id",$dealer_id[0]["dealer_id"])->field("user_id")->select()->toArray();
                        $zhurenxia_userid=array_column($zhurenxia_userid,"user_id");
                        $zhurenxia_id=Db::table("vic_user")->where("user_id","in",$zhurenxia_userid)->where("is_delete",0)->field("user_id,rank")->select()->toArray();
                        //父级主任下所有下线
                        $zhurenxia_ids=zhiwei_jinji_userids($zhurenxia_id);

                       //父级主任下线总消费
                        static $xiaxain_total_money=0;
                        $xiaxain_money=Db::table("vic_user")->where("user_id","in",$zhurenxia_ids)->where("is_delete",0)->field("expend_money")->select();
                        foreach ($xiaxain_money as $key => $value) {
                            $xiaxain_total_money+=floatval($value["expend_money"]);
                        }

                        $zong_money=$zhuren_money+$xiaxain_total_money;
                        if ($zong_money>=150000) {
                            Db::table("vic_dealer_user")->where("user_id",$dealer_id[0]["dealer_id"])->setField("rank",3);
                            Db::table("vic_user")->where("user_id",$dealer_id[0]["dealer_id"])->setField("rank",3);
                        }
                         
                    }
                     //主任的vic_user的职位改写
                    foreach ($values as $key => $v) {
                        Db::table("vic_user")->where("user_id",$v["user_id"])->setField("rank",2);
                    }             
                    
                }        
            }     
        }else{
            return false;
        }
    }
    //销售经理晋级区域总监
     function set_jingli_rank()
    {  
         //销售经理下面有>=5的user_id
        $sql="SELECT GROUP_CONCAT(a.user_id) user_id from vic_dealer_referee a JOIN vic_user b on a.user_id=b.user_id JOIN vic_dealer_user c on 
                c.user_id=a.dealer_id  where b.is_delete=0 and c.is_delete=0 GROUP BY a.dealer_id HAVING count(*) >=5";        
        $userid=Db::query($sql);
        if(count($userid)>0){
            //转换成数组
             foreach ($userid as $key => $value) {
                 $user_id[$key]["user_id"]=explode(",",$value["user_id"]);
             }
            //查找销售经理
             foreach ($user_id as $key => $value) {
                static $daili_user_id=[];
                $daili_user_id=array_merge($daili_user_id,$value["user_id"]);
            }
            $jingli[$key]=Db::table("vic_dealer_user")->where("user_id","in",$daili_user_id)->where("rank",3)->select()->toArray();
            //去掉空值
            $jingli=array_filter($jingli);
            if (count($jingli)>0){
                //满足条件晋级总监
                foreach ($jingli as $key => $values) {
                    if(count($values)>=5){//经理晋级总监  >=5
                        $dealer_id=Db::table("vic_dealer_referee")->field("dealer_id")->where("user_id",$values[0]["user_id"])->select();
                        //父级经理自己消费金额(不包含退款)
                        $dealer_money=Db::table("vic_user")->where("user_id",$dealer_id[0]["dealer_id"])->field("expend_money")->select();
                        $jingli_money=floatval($dealer_money[0]["expend_money"]);

                        //主任直接下线用户
                        $jinglixia_userid=Db::table("vic_dealer_referee")->where("dealer_id",$dealer_id[0]["dealer_id"])->field("user_id")->select()->toArray();
                        $jinglixia_userid=array_column($jinglixia_userid,"user_id");
                        $jinglixia_id=Db::table("vic_user")->where("user_id","in",$jinglixia_userid)->where("is_delete",0)->field("user_id,rank")->select()->toArray();
                        //父级经理下所有下线
                        
                        $jinglixia_ids=zhiwei_jinji_userids($jinglixia_id);
                       //父级经理下线总消费
                        static $xiaxain_total_money=0;
                        $xiaxain_money=Db::table("vic_user")->where("user_id","in",$jinglixia_ids)->where("is_delete",0)->field("expend_money")->select();
                        foreach ($xiaxain_money as $key => $value) {
                            $xiaxain_total_money+=floatval($value["expend_money"]);
                        }

                        $zong_money=$jingli_money+$xiaxain_total_money;
                        if ($zong_money>=750000) {
                            Db::table("vic_dealer_user")->where("user_id",$dealer_id[0]["dealer_id"])->setField("rank",4);
                            Db::table("vic_user")->where("user_id",$dealer_id[0]["dealer_id"])->setField("rank",4);
                        }
                         
                    }
                     //主任的vic_user的职位改写
                    foreach ($values as $key => $v) {
                        Db::table("vic_user")->where("user_id",$v["user_id"])->setField("rank",3);
                    }             
                    
                }        
            }          
        }else{
            return false;
        }
       

    }
    //dealeruser同步更新到user
     function dealerUsertToUser(){
       $data= Db::query("SELECT user_id,rank from vic_dealer_user where is_delete=0");
       foreach ($data as $key => $value) {
           Db::table("vic_user")->where("user_id",$value["user_id"])->setField("rank",$value["rank"]);
       }
    }



/**
 * 获取指定月份的第一天开始和最后一天结束的时间戳
 *
 * @param int $y 年份 $m 月份
 * @return array(本月开始时间，本月结束时间)
 */
function mFristAndLast($y = "", $m = ""){
    if ($y == "") $y = date("Y");
    if ($m == "") $m = date("m");
    $m = sprintf("%02d", intval($m));
    $y = str_pad(intval($y), 4, "0", STR_PAD_RIGHT);
 
    $m>12 || $m<1 ? $m=1 : $m=$m;
    $firstday = strtotime($y . $m . "01000000");
    $firstdaystr = date("Y-m-01", $firstday);
    $lastday = strtotime(date('Y-m-d 23:59:59', strtotime("$firstdaystr +1 month -1 day")));
 
    return array(
        "firstday" => $firstday,
        "lastday" => $lastday
    );
}

