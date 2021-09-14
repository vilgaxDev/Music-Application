<template>
    <div class="notifications-wrapper">
        <div class="card-title-medium">
            {{ title }}
        </div>
        <div class="notifications">
            <slot></slot>
        </div>
    </div>
</template>
<script>
export default {
    props: ["title"]
};
</script>
<style lang="scss" scoped>
.notifications-wrapper {
    max-width: 20em;
    border-radius: 10px;
    padding: 0.5rem;
    .title-wrapper {
        padding: 0.1em 0.35em;
    }
    .notification {
        border-radius: 5px;
        &:not(:last-child) {
            margin-bottom: 1em;
        }
        &:hover {
            background-color: rgba(105, 105, 105, 0.308);
        }
    }
}
</style>
