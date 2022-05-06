<template>
	<div>	
		<a-layout class="layout-default" id="layout-default" :class="[layoutClass]">
			<a-layout-content>
				<router-view />
			</a-layout-content>	
			<DefaultFooter></DefaultFooter>	
		</a-layout>
	</div>
</template>

<script>

	import DefaultFooter from '../components/Footers/DefaultFooter' ;

	export default ({
		components: {
		
			DefaultFooter,
		},
		data() {
			return {
			}
		},
		computed: {
			// Sets layout's element's class based on route's meta data.
			layoutClass() {
				return this.$route.meta.layoutClass ;
			}
		},
	})

</script>