<template>

	<a-card :bordered="false" class="widget-1">
		
		<a-statistic
			:title="title"
			:value="value"		
			:suffix="suffix"
			:prefix="prefix"
		
			class="text-success"
			:class="'text-' + status"
		>
		</a-statistic>
	
		<div class="icon" v-html="icon">{{suffix}}</div>
	</a-card>

</template>

<script>

	export default ({
		props: {
			title: {
				type: String,
				default: "",
			},
			value: {
				type: String,
				default: "",
			},
			prefix: {
				type: String,
				default: "",
			},
			suffix: {
				type: Number,
				default: 0,
			},
			icon: {
				type: String,
				default: "",
			},
			status: {
				type: String,
				default: "success",
			},
		},
		data() {
			return {
			}
		},
	})

</script>