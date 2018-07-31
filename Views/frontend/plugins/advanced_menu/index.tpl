{debug}
{function name="categories_top" level=0}
    {$columnIndex = 0}
    {$menuSizePercentage = 100 - (25 * $columnAmount * intval($hasTeaser))}
    {$columnCount = 4 - ($columnAmount * intval($hasTeaser))}
    <ul class="menu--list menu--level-{$level}"{if $level === 0} style="width: {$menuSizePercentage}%;"{/if}>
        {$hasItems = (!empty($LDS_Menu_Extension[{$category.id}]))}
        {if $hasItems}
            {call name="item_list" level=$level category=$category}
        {/if}
        {$hasSubs = (!empty({$category.sub}))}
        {if $hasSubs}
            {if $category['attribute']['lds_advanced_menu_img_link']}
                <li class="menu--list-item item--level-{$level}">
                <ul class="emmi-items">
            {/if}
            {call name=categories_sub categories=$category.sub level=$level+1}
            {if $category['attribute']['lds_advanced_menu_img_link']}
                </ul>
                </li>
            {/if}
        {/if}
    </ul>
{/function}

{function name="categories_sub" level=0}
    {$columnIndex = 0}
    {$columnCount = 4 - ($columnAmount * intval($hasTeaser))}
    {block name="frontend_plugins_advanced_menu_list"}
        {foreach $categories as $category}
            {if $category.hideTop}
                {continue}
            {/if}
            {if $category.external}
                {$categoryLink = $category.external}
            {/if}
            {* Item Kategorielink *}
            {$categoryLink = $category.link}
            {if $category['attribute']['lds_advanced_menu_img_link']}
                {if $category['media']['path'] }
                    {$imagepath = {$category['media']['path']}}
                {else}
                    {$imagepath = "/themes/Frontend/Responsive/frontend/_public/src/img/no-picture.jpg"}
                {/if}

                {call name=item
                link=$categoryLink
                ImgAlt="{$category.name}"
                ImgPath="{$imagepath}"
                title="{$category.name}"
                }
            {else}
                <li class="menu--list-item item--level-{$level}"{if $level === 0} style="width: 100%"{/if}>
                    {block name="frontend_plugins_advanced_menu_list_item"}
                        <a href="{$categoryLink|escapeHtml}" class="menu--list-item-link"
                           title="{$category.name|escape}"{if $category.external && $category.externalTarget} target="{$category.externalTarget}"{/if}>{$category.name}</a>
                        {if $category.sub}
                            {call name=categories_top categories=$category.sub level=$level+1}
                        {/if}
                    {/block}
                </li>
                {* Item Kategorielink END*}
                {* Item Liste *}
                {call name="item_list" level=$level category=$category}
                {* Item Liste END*}
            {/if}
        {/foreach}
    {/block}
{/function}

{function name="item_list"}
    <li class="menu--list-item item--level-{$level}">
        <ul class="emmi-items">
            {foreach $LDS_Menu_Extension[{$category.id}] as $article}
                {call name=item
                link="detail/index/sArticle/{$article.id}"
                ImgAlt="{$article['name']}"
                ImgPath="{$article['ldsImgPath']}"
                title=$article['name']
                }
            {/foreach}
        </ul>
    </li>
{/function}

{function name="item"}
    <li class="emmi-item">
        {* TODO seo URL *}
        <a class="emmi-item__link" href="{$link}">
            <img class="emmi-item__thumb" src="{$ImgPath}" alt="{$ImgAlt}">
            <span class="emmi-item__name">{$title}</span>
        </a>
    </li>
{/function}

<div class="advanced-menu" data-advanced-menu="true" data-hoverDelay="{$hoverDelay}">
    {block name="frontend_plugins_advanced_menu"}
        {foreach $sAdvancedMenu as $mainCategory}
            {if !$mainCategory.active || $mainCategory.hideTop}
                {continue}
            {/if}

            {$link = $mainCategory.link}
            {if $mainCategory.external}
                {$link = $mainCategory.external}
            {/if}
            <div class="menu--container">
                {block name="frontend_plugins_advanced_menu_main_container"}
                    <div class="button-container">
                    </div>
                    <div class="content--wrapper{if $hasCategories} has--content{/if}{if $hasTeaser} has--teaser{/if}">
                        {block name="frontend_plugins_advanced_menu_sub_categories"}
                            {call name="categories_top" category=$mainCategory}
                        {/block}
                    </div>
                {/block}
            </div>
        {/foreach}
    {/block}
</div>
