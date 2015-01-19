def insert_entry_info_hist()
#insert row into T_entry_info_hist
  
 $entry_info = Hash.new("entry")
	$entry_info['ENTRY_ID'] = Time.now.strftime("%Y-%m-%d-%H.%M.%S.").to_s + rand(100000..999999).to_s
	$entry_info['DRAFT_ENTRY_CODE'] = ''
	$entry_info['ENTRY_AMEND_TMSTMP'] = nil
	$entry_info['ENTRY_DATE'] = '01.01.2014'
	$entry_info['ENTRY_ROLE_CODE'] = 'RPRO'
	$entry_info['PRIO_TIME_STAMP'] = '2013-02-01-00.00.01.000001'
	$entry_info['REG_CHILD_CODE'] = 'B'
	$entry_info['TITLE_NO'] = $const_title
	$entry_info['ENTRY_AMEND_ID'] = nil
	$entry_info['REG_ORDER_SEQ_NO'] = '1'
	$entry_info['DRAFT_ENTRY_VERS'] = '1'
	$entry_info['LANG_CODE'] = 'ENG'
		
	puts $const_title
	
	$const_role_code = $entry_info['ENTRY_ROLE_CODE']
	$const_entry_id = $entry_info['ENTRY_ID']
	$const_end_date= $entry_info['DWH_END_DATE']
	$const_entry_date= $entry_info['ENTRY_DATE']
  sql = <<eos
INSERT INTO DC1C.T_ENTRY_INFO_HIST
  (
	ENTRY_ID,
	DRAFT_ENTRY_CODE,
	ENTRY_DATE,
	ENTRY_ROLE_CODE,
	PRIO_TIME_STAMP,
	REG_CHILD_CODE,
	TITLE_NO,
	REG_ORDER_SEQ_NO,
	DRAFT_ENTRY_VERS,
	LANG_CODE
) 
VALUES
(	
'#{$entry_info['ENTRY_ID']}',
'#{$entry_info['DRAFT_ENTRY_CODE']}',
'#{$entry_info['ENTRY_DATE']}',
'#{$entry_info['ENTRY_ROLE_CODE']}',
'#{$entry_info['PRIO_TIME_STAMP']}',
'#{$entry_info['REG_CHILD_CODE']}',
'#{$entry_info['TITLE_NO']}',
'#{$entry_info['REG_ORDER_SEQ_NO']}',
'#{$entry_info['DRAFT_ENTRY_VERS']}',
'#{$entry_info['LANG_CODE']}'
)
eos
  
  puts sql 
  $db2.execute(sql)
  $db2.commit  
 end