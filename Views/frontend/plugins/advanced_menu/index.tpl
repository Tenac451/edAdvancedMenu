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
            {call name=categories_sub categories=$category.sub level=$level+1}
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
                {* Item Kategorielink *}
                {$categoryLink = $category.link}
                {if $category.external}
                    {$categoryLink = $category.external}
                {/if}
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
            {/foreach}
        {/block}
{/function}

{function name="item_list"}
    <li class="menu--list-item item--level-{$level}">
        <ul class="emmi-items">
            {foreach $LDS_Menu_Extension[{$category.id}] as $article}
                <li class="emmi-item">
                    {* TODO seo URL *}
                    <a class="emmi-item__link" href="detail/index/sArticle/{$article.id}">
                        <img class="emmi-item__thumb" src="{$article['ldsMedia']['path']}" alt="{$article['ldsMedia']['name']}">
                        <span class="emmi-item__name">{$article['name']} </span>
                    </a>
                </li>
            {/foreach}
        </ul>
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
