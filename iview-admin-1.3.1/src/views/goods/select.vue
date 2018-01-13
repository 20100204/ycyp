<template>
    <div>
        <Select v-model="model9" style="width:200px">
            <Option value="New York" label="New York">
                <span>New York</span>
                <span style="float:right;color:#ccc">America</span>
            </Option>
            <Option value="London" label="London">
                <span>London</span>
                <span style="float:right;color:#ccc">U.K.</span>
            </Option>
            <Option value="Sydney" label="Sydney">
                <span>Sydney</span>
                <span style="float:right;color:#ccc">Australian</span>
            </Option>
        </Select>
    </div>
</template>
<script>
    export default{

    }
</script>