<script>
import VerticalNavSectionTitle from '@/@layouts/components/VerticalNavSectionTitle.vue';
import VerticalNavGroup from '@layouts/components/VerticalNavGroup.vue';
import VerticalNavLink from '@layouts/components/VerticalNavLink.vue';

export default {
  components:{
    VerticalNavSectionTitle,
    VerticalNavGroup,
    VerticalNavLink
  },
  data() {
    return {
      user: null,
      menu: [],
      isSidebar: true,
      formData: new FormData(),
    };
  },
  created() {
    // Ambil data dari localStorage
    const user = localStorage.getItem('userData');
    const parsedUser = JSON.parse(user);
    this.formData = new FormData();
    this.formData.append("id", parsedUser.id);
    this.$store.dispatch("menuManagement/authlist", this.formData)
      .then((response)=>{
        this.menu = response;
      });

    if (user) {
      this.user = JSON.parse(user);
    }
  },
}
</script>

<template>
  <div v-for="(item, hearderidx) in menu">
    <VerticalNavSectionTitle
      v-if="item.category == 'Header'"
      :item="{
        heading: item.name,
      }"
    />
      <div v-for="(parent, parentIndex) in item.items">
        
        <VerticalNavGroup
        v-if="parent.submenu && parent.submenu.length > 0"
        :item="{
          title: parent.name,
          icon: parent.icon,
        }"
      >
      <div v-for="(submenu, subIdx) in parent.submenu">
        <VerticalNavLink
        :item="{
          title: submenu.name,
          icon: submenu.icon,
          to: submenu.url,
        }"
      />
      </div>
    
    </VerticalNavGroup>
    <VerticalNavLink
    v-else
        :item="{
          title: parent.name,
          icon: parent.icon,
          to: parent.url,
        }"
      />

    </div>
  </div>
</template>
