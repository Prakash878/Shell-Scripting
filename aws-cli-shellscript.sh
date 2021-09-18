
#!/bin/bash
AWSREGION=$(aws ec2 describe-regions | jq ".Regions[].RegionName" | tr -d '"')
if [ $# -gt 0 ]; then
    echo "You have given $# regions to check the VPC List"
    for REGION in $@; do
        if [[ $AWSREGION =~ (^|[[:space:]])"$REGION"($|[[:space:]]) ]]; then
            echo "Getting VPC List For $REGION"
            for VPC in $(aws ec2 describe-vpcs --region $REGION | jq ".Vpcs[].VpcId" | tr -d '"'); do
                echo "The VPC ID is $VPC"
                echo "Getting The Subnets From VPC $VPC"
                aws ec2 describe-subnets --region $REGION --filters "Name=vpc-id,Values=$VPC" | jq ".Subnets[].SubnetId"
                echo "------------------------------------------------------"
                sleep 1
            done
        else
            echo "$REGION IS AN INVALID REGION"
            echo "------------------------------------------------------"
        fi
    done
 
else
    echo "Invalid Input. You have given $# params. Give atlast one region name."
fi

#!/bin/bash
REGIONS=$@
for REGION in $REGIONS
do
    echo "Listing VPC in REGION $REGION:"
    aws ec2 describe-vpcs --region $REGION | jq .Vpcs[].VpcId
    echo "----------------------------------------------------"
    echo "Listing VPC CIDR Blocks in REGION $REGION:"
    aws ec2 describe-vpcs --region $REGION | jq .Vpcs[].CidrBlockAssociationSet[].CidrBlock
done
 
echo "--------------------------------------------------------------"
 
#!/bin/bash
REGIONS=$@
for REGION in $REGIONS
do
    #echo "Listing VPC in REGION $REGION:"
    VPCS=$(aws ec2 describe-vpcs --region $REGION | jq .Vpcs[].VpcId)
    VPCSARRAY=($VPCS)
    LENGTH=${#VPCSARRAY[@]}
    #echo ${VPCSARRAY[@]}
    #echo "----------------------------------------------------"
    #echo "Listing VPC CIDR Blocks in REGION $REGION:"
    CIDRS=$(aws ec2 describe-vpcs --region $REGION | jq .Vpcs[].CidrBlockAssociationSet[].CidrBlock)
    CIDRSARRAY=($CIDRS)
    #echo ${CIDRSARRAY[@]}
done
 
for ((i=0;i<$LENGTH;i++))
do
    echo "${VPCSARRAY[i]} --> ${CIDRSARRAY[i]}"
done

SCRIPT TO CHECK VALID CIDR RANGES IN ALL REGIONS
#!/bin/bash
#REGIONS=$(aws ec2 describe-regions | jq ".Regions[].RegionName" | tr -d '"')
REGIONS=us-east-1
CIDR1='10.1.0.0/16'
CIDR2='172.16.0.0/16'
CIDR3='172.31.0.0/16'
for REGION in $REGIONS; do
    echo "Getting VPC Cidr Ranges In Region $REGION"
    VPCID=$(aws ec2 describe-vpcs --region $REGION | jq ".Vpcs[].VpcId" | tr -d '"')
    for VPC in $VPCID
    do
    CIDR=$(aws ec2 describe-vpcs --vpc-ids $VPC --region $REGION | jq ".Vpcs[].CidrBlock" | tr -d '"')
    if [ ${CIDR} = ${CIDR1}  -o ${CIDR} = ${CIDR2} -o ${CIDR} = ${CIDR3} ]; then
        echo $CIDR
        echo "$VPC in region $REGION is in Valid Range"
    else
        echo $CIDR
        echo "InValid Range"
    fi
    echo "-----------------------------------------------"
    done
done
 
#--------------------------------------------------------------------------------------
#!/bin/bash
REGIONS=$(aws ec2 describe-regions | jq ".Regions[].RegionName" | tr -d '"')
#REGIONS=us-east-1
CIDR1='10.1.0.0/16'
CIDR2='172.16.0.0/16'
CIDR3='172.31.0.0/16'
for REGION in $REGIONS; do
    echo "Getting VPC Cidr Ranges In Region $REGION"
    VPCID=$(aws ec2 describe-vpcs --region $REGION | jq ".Vpcs[].VpcId" | tr -d '"')
    for VPC in $VPCID
    do
    CIDR=$(aws ec2 describe-vpcs --vpc-ids $VPC --region $REGION | jq ".Vpcs[].CidrBlock" | tr -d '"')
    if [[ ${CIDR} = ${CIDR1}  || ${CIDR} = ${CIDR2} || ${CIDR} = ${CIDR3} ]]; then
        echo $CIDR
        echo "$VPC in region $REGION is in Valid Range"
    else
        echo $CIDR
        echo "InValid Range"
    fi
    echo "-----------------------------------------------"
    done
done

