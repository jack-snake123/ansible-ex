#!/bin/sh

##SDC_JenkinsUserの一覧取得
echo "###SDC_JenkinsUserの一覧" > /tmp/jenkinsuser.txt
curl -sS -k --request GET -u jenkins:11d6af5c17c9e90204ece0e1c9d355640e https://10.170.193.71:8080/asynchPeople/api/json > /tmp/jenkins.json
cat /tmp/jenkins.json | sed "s/8080\/user\//\n/g" | sed "s/\",\"fullName\":\"/ /g" | grep -oP '(?<=x).+(?="}})' | sort >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt

##SDC_JenkinsUserの権限一覧取得
echo "###SDC_JenkinsUserの権限一覧" >> /tmp/jenkinsuser.txt
echo "D_001" >> /tmp/jenkinsuser.txt
cat /jenkins/sdc/config.xml | awk '/<role name="D_001"/,/<\/role>/' | grep -oP '(?<=<sid>)........(?=</sid>)' >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "M_001" >> /tmp/jenkinsuser.txt
cat /jenkins/sdc/config.xml | awk '/<role name="M_001"/,/<\/role>/' | grep -oP '(?<=<sid>)........(?=</sid>)' >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "D_002" >> /tmp/jenkinsuser.txt
cat /jenkins/sdc/config.xml | awk '/<role name="D_002"/,/<\/role>/' | grep -oP '(?<=<sid>)........(?=</sid>)' >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "M_002" >> /tmp/jenkinsuser.txt
cat /jenkins/sdc/config.xml | awk '/<role name="M_002"/,/<\/role>/' | grep -oP '(?<=<sid>)........(?=</sid>)' >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "D_003" >> /tmp/jenkinsuser.txt
cat /jenkins/sdc/config.xml | awk '/<role name="D_003"/,/<\/role>/' | grep -oP '(?<=<sid>)........(?=</sid>)' >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "M_003" >> /tmp/jenkinsuser.txt
cat /jenkins/sdc/config.xml | awk '/<role name="M_003"/,/<\/role>/' | grep -oP '(?<=<sid>)........(?=</sid>)' >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "D_004" >> /tmp/jenkinsuser.txt
cat /jenkins/sdc/config.xml | awk '/<role name="D_004"/,/<\/role>/' | grep -oP '(?<=<sid>)........(?=</sid>)' >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "M_004" >> /tmp/jenkinsuser.txt
cat /jenkins/sdc/config.xml | awk '/<role name="M_004"/,/<\/role>/' | grep -oP '(?<=<sid>)........(?=</sid>)' >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "D_005" >> /tmp/jenkinsuser.txt
cat /jenkins/sdc/config.xml | awk '/<role name="D_005"/,/<\/role>/' | grep -oP '(?<=<sid>)........(?=</sid>)' >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "M_005" >> /tmp/jenkinsuser.txt
cat /jenkins/sdc/config.xml | awk '/<role name="M_005"/,/<\/role>/' | grep -oP '(?<=<sid>)........(?=</sid>)' >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "D_006" >> /tmp/jenkinsuser.txt
cat /jenkins/sdc/config.xml | awk '/<role name="D_006"/,/<\/role>/' | grep -oP '(?<=<sid>)........(?=</sid>)' >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "M_006" >> /tmp/jenkinsuser.txt
cat /jenkins/sdc/config.xml | awk '/<role name="M_006"/,/<\/role>/' | grep -oP '(?<=<sid>)........(?=</sid>)' >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "D_007" >> /tmp/jenkinsuser.txt
cat /jenkins/sdc/config.xml | awk '/<role name="D_007"/,/<\/role>/' | grep -oP '(?<=<sid>)........(?=</sid>)' >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "M_007" >> /tmp/jenkinsuser.txt
cat /jenkins/sdc/config.xml | awk '/<role name="M_007"/,/<\/role>/' | grep -oP '(?<=<sid>)........(?=</sid>)' >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt

##SDC_GitLabUserの一覧取得
echo "###SDC_GitLabUserの一覧" >> /tmp/jenkinsuser.txt
curl -sS -k --header "Private-Token: LL5fo3vGX3SMetFGgbGQ" --request GET 'https://10.170.193.71:8000/api/v4/users' | sed "s/\"name\":\"/\n/g" | grep -oP '.+(?=\",\"state)' | sed "s/\",\"username\":\"/ /g" >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt

##SDC_SDC_GitLabUserの権限一覧取得
echo "###SDC_GitLabUserの権限一覧" >> /tmp/jenkinsuser.txt
echo "001" >> /tmp/jenkinsuser.txt
curl -sS -k --header "Private-Token: LL5fo3vGX3SMetFGgbGQ" --request GET 'https://10.170.193.71:8000/api/v4/groups/2/members' | sed "s/.*\"name\":\"/\n/g" | grep name | sed "s/\",\"state.*access_level\":40.*/ Master/g" | sed "s/\",\"state.*access_level\":50.*/ Owner/g" | sed "s/\",\"state.*access_level\":30.*/ Developer/g" | sed "s/\".*\"/ /g" >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "002" >> /tmp/jenkinsuser.txt
curl -sS -k --header "Private-Token: LL5fo3vGX3SMetFGgbGQ" --request GET 'https://10.170.193.71:8000/api/v4/groups/17/members' | sed "s/.*\"name\":\"/\n/g" | grep name | sed "s/\",\"state.*access_level\":40.*/ Master/g" | sed "s/\",\"state.*access_level\":50.*/ Owner/g" | sed "s/\",\"state.*access_level\":30.*/ Developer/g" | sed "s/\".*\"/ /g" >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "003" >> /tmp/jenkinsuser.txt
curl -sS -k --header "Private-Token: LL5fo3vGX3SMetFGgbGQ" --request GET 'https://10.170.193.71:8000/api/v4/groups/18/members' | sed "s/.*\"name\":\"/\n/g" | grep name | sed "s/\",\"state.*access_level\":40.*/ Master/g" | sed "s/\",\"state.*access_level\":50.*/ Owner/g" | sed "s/\",\"state.*access_level\":30.*/ Developer/g" | sed "s/\".*\"/ /g" >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "004" >> /tmp/jenkinsuser.txt
curl -sS -k --header "Private-Token: LL5fo3vGX3SMetFGgbGQ" --request GET 'https://10.170.193.71:8000/api/v4/groups/19/members' | sed "s/.*\"name\":\"/\n/g" | grep name | sed "s/\",\"state.*access_level\":40.*/ Master/g" | sed "s/\",\"state.*access_level\":50.*/ Owner/g" | sed "s/\",\"state.*access_level\":30.*/ Developer/g" | sed "s/\".*\"/ /g" >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "005" >> /tmp/jenkinsuser.txt
curl -sS -k --header "Private-Token: LL5fo3vGX3SMetFGgbGQ" --request GET 'https://10.170.193.71:8000/api/v4/groups/20/members' | sed "s/.*\"name\":\"/\n/g" | grep name | sed "s/\",\"state.*access_level\":40.*/ Master/g" | sed "s/\",\"state.*access_level\":50.*/ Owner/g" | sed "s/\",\"state.*access_level\":30.*/ Developer/g" | sed "s/\".*\"/ /g" >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "006" >> /tmp/jenkinsuser.txt
curl -sS -k --header "Private-Token: LL5fo3vGX3SMetFGgbGQ" --request GET 'https://10.170.193.71:8000/api/v4/groups/21/members' | sed "s/.*\"name\":\"/\n/g" | grep name | sed "s/\",\"state.*access_level\":40.*/ Master/g" | sed "s/\",\"state.*access_level\":50.*/ Owner/g" | sed "s/\",\"state.*access_level\":30.*/ Developer/g" | sed "s/\".*\"/ /g" >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt
echo "007" >> /tmp/jenkinsuser.txt
curl -sS -k --header "Private-Token: LL5fo3vGX3SMetFGgbGQ" --request GET 'https://10.170.193.71:8000/api/v4/groups/26/members' | sed "s/.*\"name\":\"/\n/g" | grep name | sed "s/\",\"state.*access_level\":40.*/ Master/g" | sed "s/\",\"state.*access_level\":50.*/ Owner/g" | sed "s/\",\"state.*access_level\":30.*/ Developer/g" | sed "s/\".*\"/ /g" >> /tmp/jenkinsuser.txt
echo "" >> /tmp/jenkinsuser.txt

##結果のコンソール出力
cat /tmp/jenkinsuser.txt
rm -rf /tmp/jenkinsuser.txt
rm -rf /tmp/jenkins.json

